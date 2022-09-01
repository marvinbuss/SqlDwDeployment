# Define script arguments
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $SubscriptionId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $SynapseWorkspaceName,

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [int]
    $CheckPastDaysOfPipelineRuns = 1
)

# Set Azure Context
try {
    Write-Information "Setting Azure context set to subscription ID '$($SubscriptionId)'." -InformationAction Continue
    $context = Set-AzContext `
        -Subscription $SubscriptionId
    Write-Information "Azure context set to subscription ID '$($context.Subscription.Id)'." -InformationAction Continue
}
catch {
    Write-Error "Setting Azure Subscription Context failed. Please make sure you provided the correct Azure Subscription ID and that your Service Principal has access."
}

# Get Synapse Workspace
try {
    $workspace = Get-AzSynapseWorkspace `
        -Name $SynapseWorkspaceName
    Write-Information "Workspace with ID '$($workspace.Id)' found." -InformationAction Continue
}
catch {
    Write-Error "Getting Azure Synapse Workspace failed. Please make sure you provided the correct Azure Synapse Workspace Name and that your Service Principal has access."
}

# Get Synapse Triggers
$triggers = Get-AzSynapseTrigger `
    -WorkspaceName $SynapseWorkspaceName
$triggerNames = @()

# Stop all triggers
foreach ($trigger in $triggers) {
    Write-Verbose $trigger.Name

    if ($trigger.Properties.RuntimeState.Value -eq "Started") {

        Write-Information "Stopping Trigger '$($trigger.Name)'" -InformationAction Continue

        # Both options are currently failing: https://github.com/Azure/azure-powershell/issues/16368
        # $success = Stop-AzSynapseTrigger `
        #     -WorkspaceName $SynapseWorkspaceName `
        #     -Name $trigger.Name -Verbose -AsJob
        # $trigger | Stop-AzSynapseTrigger

        # Workaround: Call API Endpoint manually
        $token = Get-AzAccessToken -ResourceUrl "https://dev.azuresynapse.net"
        $authHeader = @{
            'Content-Type'  = 'application/octet-stream'
            'Authorization' = 'Bearer ' + $token.Token
        }
        $response = Invoke-WebRequest `
            -Method POST `
            -Uri "https://$($SynapseWorkspaceName).dev.azuresynapse.net/triggers/$($trigger.Name)/stop?api-version=2020-12-01" `
            -Headers $authHeader

        if ($response.StatusCode -lt 400 && $response.StatusCode -ge 200) {
            Write-Information "Stopped Trigger '$($trigger.Name)' successfully." -InformationAction Continue
        }
        else {
            Write-Error "Failed to stop trigger '$($trigger.Name)'."
        }

        # Append to List of Trigger names
        $triggerNames.Add($trigger.Name)
    }
}

# Get Timestamp
$timestamp = Get-Date -AsUTC

# Get Pipelines
$pipelines = Get-AzSynapsePipeline `
    -WorkspaceName $SynapseWorkspaceName

# Get Pipeline Runs
foreach ($pipeline in $pipelines) {
    Write-Information "Checking runs for pipeline '$($pipeline.Name)'." -InformationAction Continue
    $pipelineRuns = Get-AzSynapsePipelineRun `
        -WorkspaceName $SynapseWorkspaceName `
        -PipelineName $pipeline.Name `
        -RunStartedAfter $timestamp.AddDays(-$CheckPastDaysOfPipelineRuns) `
        -RunStartedBefore $timestamp

    foreach ($pipelineRun in $pipelineRuns) {
        if ($pipelineRun.Status -eq "InProgress") {
            Write-Information "Pipeline with Name '$($pipeline.Name)' is still in progress (Run ID: '$($pipelineRun.RunId)'). Waiting for pipeline to complete run." -InformationAction Continue

            do {
                # Sleep for 1 second
                Start-Sleep -Seconds 1

                # Get status of pipeline run
                $pipelineRun = Get-AzSynapsePipelineRun `
                    -WorkspaceName $SynapseWorkspaceName `
                    -PipelineRunId $pipelineRun.RunId
            } while (
                $pipelineRun.Status -eq "InProgress"
            )

            Write-Information "Pipeline with Name '$($pipeline.Name)' completed with status '$($pipelineRun.Status)' (Run ID: '$($pipelineRun.RunId)')." -InformationAction Continue
        }
    }
}

Write-Information "Successfully prepared Azure Synapse Workspace '$($SynapseWorkspaceName)' in Azure subscription '$($SubscriptionId)' for rollout of changes." -InformationAction Continue
Write-Output "::set-output name=triggerNames::$($triggerNames))"

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
    Write-Output "Setting Azure context set to subscription ID '$($SubscriptionId)'."
    $context = Set-AzContext `
        -Subscription $SubscriptionId
    Write-Output "Azure context set to subscription ID '$($context.Subscription.Id)'."
}
catch {
    Write-Error "Setting Azure Subscription Context failed. Please make sure you provided the correct Azure Subscription ID and that your Service Principal has access."
}

# Get Synapse Workspace
try {
    $workspace = Get-AzSynapseWorkspace `
        -Name $SynapseWorkspaceName
    Write-Output "Workspace with ID '$($workspace.Id)' found."
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
    Write-Output "Checking Trigger '$($trigger.Name)' with status $($trigger.Properties.RuntimeState)"

    if ($trigger.Properties.RuntimeState -eq "Started") {
        Write-Output "Stopping Trigger '$($trigger.Name)'"

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
            Write-Output "Stopped Trigger '$($trigger.Name)' successfully."
        }
        else {
            Write-Error "Failed to stop trigger '$($trigger.Name)'."
        }

        # Append to List of Trigger names
        $triggerNames += $trigger.Name
    }
}
# Print stopped trigger names
$triggerNamesOutput =  $triggerNames -join ","
Write-Output "Stopped Triggers: $($triggerNamesOutput)"

# Get Timestamp
$timestamp = Get-Date -AsUTC

# Get Pipelines
$pipelines = Get-AzSynapsePipeline `
    -WorkspaceName $SynapseWorkspaceName

# Get Pipeline Runs
foreach ($pipeline in $pipelines) {
    Write-Output "Checking runs for pipeline '$($pipeline.Name)'."
    $pipelineRuns = Get-AzSynapsePipelineRun `
        -WorkspaceName $SynapseWorkspaceName `
        -PipelineName $pipeline.Name `
        -RunStartedAfter $timestamp.AddDays(-$CheckPastDaysOfPipelineRuns) `
        -RunStartedBefore $timestamp

    foreach ($pipelineRun in $pipelineRuns) {
        if ($pipelineRun.Status -eq "InProgress") {
            Write-Output "Pipeline with Name '$($pipeline.Name)' is still in progress (Run ID: '$($pipelineRun.RunId)'). Waiting for pipeline to complete run."

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

            Write-Output "Pipeline with Name '$($pipeline.Name)' completed with status '$($pipelineRun.Status)' (Run ID: '$($pipelineRun.RunId)')."
        }
    }
}

Write-Output "Successfully prepared Azure Synapse Workspace '$($SynapseWorkspaceName)' in Azure subscription '$($SubscriptionId)' for rollout of changes."
Write-Output "::set-output name=triggerNames::$($triggerNamesOutput)"

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

    [Parameter(Mandatory = $true)]
    [AllowEmptyString()]
    [string]
    $TriggerNames = ""
)

# Parse TriggerNames
if ([string]::IsNullOrWhiteSpace($TriggerNames)) {
    Write-Output "No Trigger Names provided."
    $TriggerNamesArray = @()
}
else {
    Write-Output "Parsing Trigger Names."
    $TriggerNamesArray = $TriggerNames.Split(",")
}

# Set Azure Context
try {
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

# Enable Triggers
foreach ($triggerName in $TriggerNamesArray) {
    # Get Synapse Trigger
    Write-Output "Get Trigger '$($triggerName)'"

    try {
        $trigger = Get-AzSynapseTrigger `
            -WorkspaceName $SynapseWorkspaceName `
            -Name $triggerName

        # # Both options are currently failing: https://github.com/Azure/azure-powershell/issues/16368
        # # Start Synapse Trigger
        # Write-Output "Start Trigger '$($trigger.Name)'"
        # Start-AzSynapseTrigger `
        #     -WorkspaceName $SynapseWorkspaceName `
        #     -Name $trigger.Name

        # Workaround: Call API Endpoint manually
        $token = Get-AzAccessToken -ResourceUrl "https://dev.azuresynapse.net"
        $authHeader = @{
            'Content-Type'  = 'application/octet-stream'
            'Authorization' = 'Bearer ' + $token.Token
        }
        $response = Invoke-WebRequest `
            -Method POST `
            -Uri "https://$($SynapseWorkspaceName).dev.azuresynapse.net/triggers/$($trigger.Name)/start?api-version=2020-12-01" `
            -Headers $authHeader

        if ($response.StatusCode -lt 400 && $response.StatusCode -ge 200) {
            Write-Output "Started Trigger '$($trigger.Name)' successfully."
        }
        else {
            Write-Error "Failed to start trigger '$($trigger.Name)'."
        }
    }
    catch {
        Write-Error "Failed to get trigger '$($trigger.Name)'."
    }
}

Write-Output "Successfully ran post-processing for Azure Synapse Workspace '$($SynapseWorkspaceName)' in Azure subscription '$($SubscriptionId)' after rollout of changes."

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
    [ValidateNotNullOrEmpty()]
    [string[]]
    $TriggerNames = @()
)

# Set Azure Context
try {
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

# Enable Triggers
foreach ($triggerName in $TriggerNames) {
    # Get Synapse Trigger
    Write-Information "Get Trigger '$($triggerName)'" -InformationAction Continue
    $trigger = Get-AzSynapseTrigger `
        -WorkspaceName $SynapseWorkspaceName `
        -Name $triggerName

    # # Both options are currently failing: https://github.com/Azure/azure-powershell/issues/16368
    # # Start Synapse Trigger
    # Write-Information "Start Trigger '$($trigger.Name)'" -InformationAction Continue
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
        Write-Information "Stopped Trigger '$($trigger.Name)' successfully." -InformationAction Continue
    }
    else {
        Write-Error "Failed to stop trigger '$($trigger.Name)'."
    }
}

Write-Information "Successfully ran pot-processing for Azure Synapse Workspace '$($SynapseWorkspaceName)' in Azure subscription '$($SubscriptionId)' after rollout of changes." -InformationAction Continue

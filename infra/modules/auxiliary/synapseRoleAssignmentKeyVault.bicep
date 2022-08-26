// Licensed under the MIT license.

// The module contains a template to create a role assignment of the Synapse MSI to a KeyVault.
targetScope = 'resourceGroup'

// Parameters
param synapseId string
param keyVaultId string

// Variables
var keyVaultName = length(split(keyVaultId, '/')) >= 9 ? last(split(keyVaultId, '/')) : 'incorrectSegmentLength'
var synapseSubscriptionId = length(split(synapseId, '/')) >= 9 ? split(synapseId, '/')[2] : subscription().subscriptionId
var synapseResourceGroupName = length(split(synapseId, '/')) >= 9 ? split(synapseId, '/')[4] : resourceGroup().name
var synapseName = length(split(synapseId, '/')) >= 9 ? last(split(synapseId, '/')) : 'incorrectSegmentLength'

// Resources
resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' existing = {
  name: keyVaultName
}

resource synapse 'Microsoft.Synapse/workspaces@2021-06-01' existing = {
  name: synapseName
  scope: resourceGroup(synapseSubscriptionId, synapseResourceGroupName)
}

resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(uniqueString(keyVault.id, synapse.id))
  scope: keyVault
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')
    principalId: synapse.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

// Outputs

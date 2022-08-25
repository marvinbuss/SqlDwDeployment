// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'resourceGroup'

// General parameters
@description('Specifies the location for all resources.')
param location string
@allowed([
  'dev'
  'tst'
  'prd'
])
@description('Specifies the environment of the deployment.')
param environment string
@minLength(2)
@maxLength(10)
@description('Specifies the prefix for all resources created in this deployment.')
param prefix string
@description('Specifies the tags that you want to apply to all resources.')
param tags object = {}

// Resource parameters
@description('Specifies the Synapse repository configuration for the workspace.')
param synapseRepositoryConfiguration object = {}
@description('Specifies whether an Azure SQL Pool should be deployed inside your Synapse workspace as part of the template. If you selected dataFactory as processingService, leave this value as is.')
param enableSqlPool bool = false
@description('Specifies the resource ID of the central Purview instance.')
param purviewId string = ''
@description('Specifies whether role assignments should be enabled.')
param enableRoleAssignments bool = false

// Network parameters
@description('Specifies the resource ID of the subnet to which all services will connect.')
param subnetId string

// Private DNS Zone parameters
@description('Specifies the resource ID of the private DNS zone for KeyVault.')
param privateDnsZoneIdKeyVault string = ''
@description('Specifies the resource ID of the private DNS zone for Synapse Dev.')
param privateDnsZoneIdSynapseDev string = ''
@description('Specifies the resource ID of the private DNS zone for Synapse Sql.')
param privateDnsZoneIdSynapseSql string = ''
@description('Specifies the resource ID of the private DNS zone for Blob Storage.')
param privateDnsZoneIdBlob string = ''
@description('Specifies the resource ID of the private DNS zone for Data Lake Storage.')
param privateDnsZoneIdDfs string = ''

// Variables
var name = toLower('${prefix}-${environment}')
var tagsDefault = {
  Project: 'Synapse Automation'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
}
var tagsJoined = union(tagsDefault, tags)
var dataLake001Name = '${name}-lake001'
var keyVault001Name = '${name}-vault001'
var synapse001Name = '${name}-synapse001'
var fileSystemNames = [
  'synapse'
]

// Resources
module dataLake001 'modules/services/datalake.bicep' = {
  name: 'dataLake001'
  scope: resourceGroup()
  params: {
    location: location
    tags: tags
    storageName: dataLake001Name
    fileSystemNames: fileSystemNames
    subnetId: subnetId
    privateDnsZoneIdBlob: privateDnsZoneIdBlob
    privateDnsZoneIdDfs: privateDnsZoneIdDfs
  }
}

module keyVault001 'modules/services/keyvault.bicep' = {
  name: 'keyVault001'
  scope: resourceGroup()
  params: {
    location: location
    keyvaultName: keyVault001Name
    tags: tagsJoined
    subnetId: subnetId
    privateDnsZoneIdKeyVault: privateDnsZoneIdKeyVault
  }
}

module synapse001 'modules/services/synapse.bicep' = {
  name: 'synapse001'
  scope: resourceGroup()
  params: {
    location: location
    synapseName: synapse001Name
    tags: tagsJoined
    subnetId: subnetId
    purviewId: purviewId
    enableSqlPool: enableSqlPool
    synapseSqlAdminGroupName: ''
    synapseSqlAdminGroupObjectID: ''
    synapseComputeSubnetId: ''
    synapseDefaultStorageAccountId: dataLake001.outputs.storageId
    synapseDefaultStorageAccountFileSystemId: dataLake001.outputs.storageFileSystemIds[0].storageFileSystemId
    synapseRepositoryConfiguration: synapseRepositoryConfiguration
    privateDnsZoneIdSynapseDev: privateDnsZoneIdSynapseDev
    privateDnsZoneIdSynapseSql: privateDnsZoneIdSynapseSql
  }
}

module synapse001RoleAssignmentStorage 'modules/auxiliary/synapseRoleAssignmentStorage.bicep' = if(enableRoleAssignments) {
  name: 'synapse001RoleAssignmentStorage'
  scope: resourceGroup()
  params: {
    storageAccountFileSystemId: dataLake001.outputs.storageFileSystemIds[0].storageFileSystemId
    synapseId: synapse001.outputs.synapseId
  }
}

module synapse001RoleAssignmentKeyVault 'modules/auxiliary/synapseRoleAssignmentKeyVault.bicep' = if(enableRoleAssignments) {
  name: 'synapse001RoleAssignmentKeyVault'
  scope: resourceGroup()
  params: {
    keyVaultId: keyVault001.outputs.keyvaultId
    synapseId: synapse001.outputs.synapseId
  }
}

// Outputs

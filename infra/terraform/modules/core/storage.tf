data "azurerm_storage_account" "datalake_synapse" {
  name                = local.datalake_synapse.name
  resource_group_name = local.datalake_synapse.resource_group_name
}

data "azurerm_storage_account" "datalake_data" {
  name                = local.datalake_data.name
  resource_group_name = local.datalake_data.resource_group_name
}

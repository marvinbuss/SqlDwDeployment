module "datalake_main" {
  source = "./modules/datalake"

  location                       = var.location
  resource_group_name            = azurerm_resource_group.storage_rg.name
  tags                           = var.tags
  datalake_name                  = "${local.prefix}-st-data"
  datalake_filesystem_names      = []
  datalake_replication_type      = "ZRS"
  sftp_enabled                   = false
  subnet_id                      = azapi_resource.storage_subnet.id
  enable_queue_private_endpoint  = false
  enable_table_private_endpoint  = false
  private_dns_zone_id_blob       = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs        = var.private_dns_zone_id_dfs
  private_dns_zone_id_queue      = var.private_dns_zone_id_queue
  private_dns_zone_id_table      = var.private_dns_zone_id_table
  data_platform_subscription_ids = []
}

module "datalake_workspace" {
  source = "./modules/datalake"

  location                       = var.location
  resource_group_name            = azurerm_resource_group.storage_rg.name
  tags                           = var.tags
  datalake_name                  = "${local.prefix}-st-wsp"
  datalake_filesystem_names      = []
  datalake_replication_type      = "ZRS"
  sftp_enabled                   = false
  subnet_id                      = azapi_resource.storage_subnet.id
  enable_queue_private_endpoint  = true
  enable_table_private_endpoint  = true
  private_dns_zone_id_blob       = var.private_dns_zone_id_blob
  private_dns_zone_id_dfs        = var.private_dns_zone_id_dfs
  private_dns_zone_id_queue      = var.private_dns_zone_id_queue
  private_dns_zone_id_table      = var.private_dns_zone_id_table
  data_platform_subscription_ids = []
}

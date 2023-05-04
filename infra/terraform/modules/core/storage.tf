data "azurerm_storage_account" "datalake_workspace" {
  name                = local.datalake_workspace.name
  resource_group_name = local.datalake_workspace.resource_group_name
}

resource "azapi_resource" "container_workspace" {
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01"
  name      = var.prefix
  parent_id = "${data.azurerm_storage_account.datalake_workspace.id}/blobServices/default"

  body = jsonencode({
    properties = {
      publicAccess = "None"
      metadata     = {}
    }
  })
}

data "azurerm_storage_account" "datalake_main" {
  name                = local.datalake_main.name
  resource_group_name = local.datalake_main.resource_group_name
}

resource "azapi_resource" "container_main" {
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01"
  name      = var.prefix
  parent_id = "${data.azurerm_storage_account.datalake_main.id}/blobServices/default"

  body = jsonencode({
    properties = {
      publicAccess = "None"
      metadata     = {}
    }
  })
}

resource "azurerm_storage_account_local_user" "storage_account_local_user" {
  name                 = lower("${var.prefix}user001")
  storage_account_id   = data.azurerm_storage_account.datalake_main.id
  ssh_key_enabled      = false
  ssh_password_enabled = true
  home_directory       = "sftp"
  permission_scope {
    permissions {
      create = true
      delete = true
      list   = true
      read   = true
      write  = true
    }
    service       = "blob"
    resource_name = azapi_resource.container_main.name
  }
}

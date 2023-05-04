# resource "azurerm_synapse_workspace" "synapse_workspace" {
#   name                = "${local.prefix}-synw001"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags                = var.tags
#   identity {
#     type = "SystemAssigned"
#   }

#   aad_admin                            = var.workspace_aad_admins
#   compute_subnet_id                    = ""
#   data_exfiltration_protection_enabled = true
#   # github_repo {
#   #   account_name = ""
#   #   branch_name = ""
#   #   git_url = ""
#   #   repository_name = ""
#   #   root_folder = "/code/synapse"
#   # }
#   linking_allowed_for_aad_tenant_ids   = []
#   managed_resource_group_name          = "${local.prefix}-synw001"
#   managed_virtual_network_enabled      = true
#   public_network_access_enabled        = false
#   sql_aad_admin                        = var.sql_aad_admins
#   sql_identity_control_enabled         = true
#   storage_data_lake_gen2_filesystem_id = ""
# }

# resource "azurerm_synapse_firewall_rule" "synapse_firewall_rule" {
#   name = "AllowMe"
#   synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id

#   start_ip_address = ""
#   end_ip_address = ""
# }

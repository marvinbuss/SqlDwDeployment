module "core" {
  source = "./modules/core"

  location                      = var.location
  environment                   = var.environment
  prefix                        = var.prefix
  tags                          = var.tags
  datalake_id_main              = module.datalake_main.datalake_id
  datalake_id_workspace         = module.datalake_workspace.datalake_id
  subnet_id                     = azapi_resource.core_subnet.id
  private_dns_zone_id_key_vault = var.private_dns_zone_id_key_vault
}

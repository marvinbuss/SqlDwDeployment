locals {
  prefix = "${lower(var.prefix)}-${var.environment}"

  datalake_workspace = {
    resource_group_name = try(split("/", var.datalake_id_workspace)[4], "")
    name                = try(split("/", var.datalake_id_workspace)[8], "")
  }

  datalake_main = {
    resource_group_name = try(split("/", var.datalake_id_main)[4], "")
    name                = try(split("/", var.datalake_id_main)[8], "")
  }
}

locals {
  datalake_synapse = {
    resource_group_name = try(split("/", var.datalake_id_synapse)[4], "")
    name                = try(split("/", var.datalake_id_synapse)[8], "")
  }

  datalake_data = {
    resource_group_name = try(split("/", var.datalake_id_data)[4], "")
    name                = try(split("/", var.datalake_id_data)[8], "")
  }
}

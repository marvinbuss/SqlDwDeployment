variable "location" {
  description = "Specifies the location for all Azure resources."
  type        = string
  sensitive   = false
}

variable "environment" {
  description = "Specifies the environment of the deployment."
  type        = string
  sensitive   = false
  default     = "dev"
  validation {
    condition     = contains(["dev", "tst", "prd"], var.environment)
    error_message = "Please use an allowed value: \"dev\", \"tst\" or \"prd\"."
  }
}

variable "prefix" {
  description = "Specifies the prefix for all resources created in this deployment."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.prefix) >= 2 && length(var.prefix) <= 10
    error_message = "Please specify a prefix with more than two and less than 10 characters."
  }
}

variable "tags" {
  description = "Specifies the tags that you want to apply to all resources."
  type        = map(string)
  sensitive   = false
  default     = {}
}

variable "resource_group_name" {
  description = "Specifies the resource group name"
  type        = string
  sensitive   = false
}

variable "datalake_id_main" {
  description = "Specifies the resource id of the main data lake."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.datalake_id_main == "" || length(split("/", var.datalake_id_main)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "datalake_id_workspace" {
  description = "Specifies the resource id of the workspace data lake."
  type        = string
  sensitive   = false
  default     = ""
  validation {
    condition     = var.datalake_id_workspace == "" || length(split("/", var.datalake_id_workspace)) == 9
    error_message = "Please specify a valid resource ID."
  }
}

variable "subnet_id" {
  description = "Specifies the resource ID of the subnet used for the datalake."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.subnet_id)) == 11
    error_message = "Please specify a valid resource ID."
  }
}

variable "private_dns_zone_id_key_vault" {
  description = "Specifies the resource ID of the private DNS zone for Azure Key Vault endpoints."
  type        = string
  sensitive   = false
  validation {
    condition     = var.private_dns_zone_id_key_vault == "" || (length(split("/", var.private_dns_zone_id_key_vault)) == 9 && endswith(var.private_dns_zone_id_key_vault, "privatelink.vaultcore.azure.net"))
    error_message = "Please specify a valid resource ID for the private DNS Zone."
  }
}

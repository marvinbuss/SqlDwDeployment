terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.54.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.5.0"
    }
  }
}

resource "azurerm_resource_group" "cicd_rg" {
  name     = "${local.prefix}-cicd-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "storage_rg" {
  name     = "${local.prefix}-storage-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "runtimes_rg" {
  name     = "${local.prefix}-runtimes-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "gateways_rg" {
  name     = "${local.prefix}-gateways-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "core_rg" {
  name     = "${local.prefix}-core-rg"
  location = var.location
  tags     = var.tags
}

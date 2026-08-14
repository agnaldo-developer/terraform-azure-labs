locals {
  resource_group_name = "rg-tf-${var.environment}-lab03"
  vnet_name           = "vnet-tf-${var.environment}-lab03"

  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "terraform-training"
  }
}

module "network" {
  source = "../../modules/network"

  resource_group_name = local.resource_group_name
  location            = var.location
  vnet_name           = local.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = local.common_tags
}
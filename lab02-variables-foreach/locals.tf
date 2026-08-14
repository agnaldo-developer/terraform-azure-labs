locals {
  resource_group_name = "rg-tf-${var.environment}-lab02"
  vnet_name           = "vnet-tf-${var.environment}-lab02"

  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "terraform-training"
  }
}
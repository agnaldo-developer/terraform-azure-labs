terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "sttfstatezc08rvuq"
    container_name       = "tfstate"
    key                  = "lab03-dev.tfstate"

    use_azuread_auth = true
    use_oidc         = true
  }
}

provider "azurerm" {
  features {}
}
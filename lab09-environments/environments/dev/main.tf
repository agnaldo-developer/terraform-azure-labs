locals {
  resource_group_name = "rg-tf-${var.environment}-lab09"

  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "lab09-environments"
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

module "network" {
  source = "../../../lab08-enterprise/modules/network"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  vnet_name = "vnet-tf-${var.environment}-lab09"

  address_space = ["10.90.0.0/16"]

  subnets = {
    web = {
      address_prefix = "10.90.1.0/24"
    }

    app = {
      address_prefix = "10.90.2.0/24"
    }
  }

  tags = local.common_tags
}

module "nsg_web" {
  source = "../../../lab08-enterprise/modules/nsg"

  name                = "nsg-${var.environment}-web"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.network.subnet_ids["web"]

  security_rules = {
    allow_http = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = local.common_tags
}

module "nsg_app" {
  source = "../../../lab08-enterprise/modules/nsg"

  name                = "nsg-${var.environment}-app"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.network.subnet_ids["app"]

  security_rules = {
    allow_web_to_app = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.90.1.0/24"
      destination_address_prefix = "10.90.2.0/24"
    }
  }

  tags = local.common_tags
}
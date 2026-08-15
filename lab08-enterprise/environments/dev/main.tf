locals {
  resource_group_name = "rg-tf-${var.environment}-lab08"
  vnet_name           = "vnet-tf-${var.environment}-lab08"

  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "terraform-training"
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  vnet_name = local.vnet_name

  address_space = [
    "10.80.0.0/16"
  ]

  subnets = {
    web = {
      address_prefix = "10.80.1.0/24"
    }

    app = {
      address_prefix = "10.80.2.0/24"
    }
  }

  tags = local.common_tags
}

module "nsg_web" {
  source = "../../modules/nsg"

  name                = "nsg-web"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  subnet_id = module.network.subnet_ids["web"]

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
  source = "../../modules/nsg"

  name                = "nsg-app"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  subnet_id = module.network.subnet_ids["app"]

  security_rules = {
    allow_web_to_app = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.80.1.0/24"
      destination_address_prefix = "10.80.2.0/24"
    }
  }

  tags = local.common_tags
}

module "compute" {
  source = "../../modules/compute"

  vm_name             = "vm-${var.environment}-app01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  subnet_id = module.network.subnet_ids["app"]

  vm_size        = "Standard_D2ads_v6"
  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key

  tags = local.common_tags
}
resource "azurerm_resource_group" "lab" {
  name=var.resource_group_name
  location = var.location

  tags = {
    environment = "lab"
    managed_by  = "terraform"
    purpose     = "terraform-training"
    owner       = "agnaldo"
  }
}

resource "azurerm_virtual_network" "lab" {
  name                = var.vnet_name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  address_space = [
    "10.10.0.0/16"
  ]
}

resource "azurerm_subnet" "web" {
  name                 = "snet-web"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name

  address_prefixes = [
    "10.10.1.0/24"
  ]
}

resource "azurerm_network_security_group" "web" {
  name                = "nsg-web"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

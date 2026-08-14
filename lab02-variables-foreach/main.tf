resource "azurerm_resource_group" "lab" {
  name     = local.resource_group_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_virtual_network" "lab" {
  name                = local.vnet_name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  address_space = var.vnet_address_space

  tags = local.common_tags
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = "snet-${each.key}"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name

  address_prefixes = [
    each.value.address_prefix
  ]
}
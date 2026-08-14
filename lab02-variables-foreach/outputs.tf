output "resource_group_name" {
  value = azurerm_resource_group.lab.name
}

output "vnet_name" {
  value = azurerm_virtual_network.lab.name
}

output "subnets" {
  value = {
    for name, subnet in azurerm_subnet.subnets :
    name => subnet.id
  }
}
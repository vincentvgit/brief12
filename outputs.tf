
output "vm1" {
  value = azurerm_virtual_machine.test[0].name
}


output "ip_vm1" {
  value = azurerm_network_interface.test[0].private_ip_address
}

output "ip_vm2" {
  value = azurerm_network_interface.test[1].private_ip_address
}

output "vm2" {
  value = azurerm_virtual_machine.test[1].name
}

output "region" {
  value = azurerm_resource_group.test.location
}

output "resource_group_name" {
  value = azurerm_resource_group.test.name
}

output "public_ip_address" {
  value = azurerm_public_ip.test.ip_address
}
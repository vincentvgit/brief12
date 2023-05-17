#name of vm1
output "vm1" {
  value = azurerm_virtual_machine.test[0].name
}

#ip of vm1
output "ip_vm1" {
  value = azurerm_network_interface.test[0].private_ip_address
}
#ip of vm2
output "ip_vm2" {
  value = azurerm_network_interface.test[1].private_ip_address
}
#name of vm2
output "vm2" {
  value = azurerm_virtual_machine.test[1].name
}
#region of resource group
output "region" {
  value = azurerm_resource_group.test.location
}
#name of resource group
output "resource_group_name" {
  value = azurerm_resource_group.test.name
}
#ip of loadbalancer
output "public_ip_address" {
  value = azurerm_public_ip.test.ip_address
}

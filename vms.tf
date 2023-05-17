 
 #resources for my vms
 #creation of the virtual network
 resource "azurerm_virtual_network" "test" {
   name                = "monreseau"
   address_space       = ["10.0.0.0/16"]
   location            = azurerm_resource_group.test.location
   resource_group_name = azurerm_resource_group.test.name
 }
#creation of the managed disks
  resource "azurerm_managed_disk" "test" {
   count                = 2
   name                 = "datadisk_existing_${count.index}"
   location             = azurerm_resource_group.test.location
   resource_group_name  = azurerm_resource_group.test.name
   storage_account_type = "Standard_LRS"
   create_option        = "Empty"
   disk_size_gb         = "20"
 }
#creation of vms
 resource "azurerm_virtual_machine" "test" {
   count                 = 2
   name                  = "ubuntu${count.index}"
   location              = azurerm_resource_group.test.location
   availability_set_id   = azurerm_availability_set.avset.id
   resource_group_name   = azurerm_resource_group.test.name
   network_interface_ids = [element(azurerm_network_interface.test.*.id, count.index)]
   vm_size               = "Standard_DS1_v2"

   # Uncomment this line to delete the OS disk automatically when deleting the VM
    delete_os_disk_on_termination = true

   # Uncomment this line to delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "16.04-LTS"
     version   = "latest"
   }

   storage_os_disk {
     name              = "myosdisk${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }

  

   storage_data_disk {
     name            = element(azurerm_managed_disk.test.*.name, count.index)
     managed_disk_id = element(azurerm_managed_disk.test.*.id, count.index)
     create_option   = "Attach"
     lun             = 1
     disk_size_gb    = element(azurerm_managed_disk.test.*.disk_size_gb, count.index)
   }

   os_profile {
     computer_name  = "hostname"
     admin_username = "vinceent"
     admin_password = "Azerty123!"
   }

   os_profile_linux_config {
     disable_password_authentication = false
   }

   

   tags = {
     environment = "staging"
   }
 }

 

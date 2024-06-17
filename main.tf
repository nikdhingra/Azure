data "azurerm_resource_group" "rg" {
    name = "1-7ce5f720-playgrpund-sandbox"
  
}

resource "azurerm_network_security_group" "development" {
  name                = "dev-security"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "development" {
  name                = "dev-network"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "dev-subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "dev-subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.development.id
  }

  tags = {
    environment = "development"
  }
}
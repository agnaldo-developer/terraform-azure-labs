resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "backend" {
  name     = "rg-terraform-backend"
  location = "brazilsouth"

  tags = {
    managed_by = "terraform"
    purpose    = "terraform-remote-state"
  }
}

resource "azurerm_storage_account" "backend" {
  name = "sttfstate${random_string.storage_suffix.result}"

  resource_group_name = azurerm_resource_group.backend.name
  location            = azurerm_resource_group.backend.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    managed_by = "terraform"
    purpose    = "terraform-remote-state"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.backend.id
  container_access_type = "private"
}
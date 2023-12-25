locals {
  identity_resource_group_name = "module-azure-blob-storage-example-identities"
  storage_resource_group_name = "module-azure-blob-storage-example-main"
}

resource "azurerm_resource_group" "this" {
  name     = local.identity_resource_group_name
  location = var.location
}

resource "azurerm_user_assigned_identity" "app1" {
  name                = "app1"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_user_assigned_identity" "app2" {
  name                = "app2"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "storage_blob" {
  source  = "./../"

  depends_on = [ azurerm_user_assigned_identity.app1, azurerm_user_assigned_identity.app2 ]

  name = "module-example"
  environment = "prod"
  resource_group_name = local.storage_resource_group_name
  location = var.location
  container_names = [ "test1", "test2" ]
  rbac = [
    {
        identity_name = "app1"
        identity_resource_group = local.identity_resource_group_name
        container_name = "test1"
        role = "Storage Blob Data Contributor"
    }
  ]
}

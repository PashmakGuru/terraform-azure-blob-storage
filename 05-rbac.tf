data "azurerm_user_assigned_identity" "identity" {
  for_each            = local.rbac
  name                = each.value.identity_name
  resource_group_name = each.value.identity_resource_group
}

resource "azurerm_role_assignment" "rbac" {
  for_each             = local.rbac
  scope                = azurerm_storage_container.containers[each.value.container_name].resource_manager_id
  role_definition_name = each.value.role
  principal_id         = data.azurerm_user_assigned_identity.identity[each.key].principal_id
}

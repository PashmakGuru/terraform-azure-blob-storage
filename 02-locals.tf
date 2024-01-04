locals {
  id = "${var.name}-${var.environment}"
  common_tags = {
    module = "blob-storage"
    name   = var.name
    env    = var.environment
  }
  rbac = {
    for r in var.rbac :
    "${r.identity_resource_group}-${r.identity_name}" => r
  }
}

locals {
  mandatory_tags = {
    environment = var.environment
    owner       = var.owner
    cost_center = var.cost_center
    application = var.application
    managed_by  = var.managed_by
  }

  # additional_tags first so the mandatory keys always win if a caller
  # accidentally tries to set one of them via additional_tags too.
  tags = merge(var.additional_tags, local.mandatory_tags)
}

resource "oci_identity_tag" "this" {
  description      = var.description
  name             = var.name
  tag_namespace_id = var.tag_namespace_id
  defined_tags     = var.defined_tags
  freeform_tags    = var.freeform_tags
  is_cost_tracking = var.is_cost_tracking
  is_retired       = var.is_retired

  dynamic "validator" {
    for_each = var.validators
    content {
      validator_type = validator.value.validator_type
      values         = validator.value.values
    }
  }
}

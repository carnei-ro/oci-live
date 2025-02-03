resource "oci_identity_dynamic_group" "this" {
  compartment_id = var.compartment_id
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
  description    = var.description
  matching_rule  = var.matching_rule
  name           = var.name
}

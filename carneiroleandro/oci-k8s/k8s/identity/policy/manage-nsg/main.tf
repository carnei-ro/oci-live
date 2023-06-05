resource "oci_identity_policy" "this" {
  compartment_id = var.compartment_id
  description    = var.description
  name           = var.name
  statements     = var.statements
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
  version_date   = var.version_date
}

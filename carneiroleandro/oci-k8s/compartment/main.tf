resource "oci_identity_compartment" "this" {
  compartment_id = var.compartment_id
  description    = var.description
  name           = var.name

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
  enable_delete = var.enable_delete
}

resource "oci_identity_tag_namespace" "this" {
  #Required
  compartment_id = var.compartment_id
  description    = var.description
  name           = var.name

  #Optional
  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
  is_retired    = var.is_retired
}

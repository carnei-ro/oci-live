resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  defined_tags   = var.defined_tags
  display_name   = var.display_name
  freeform_tags  = var.freeform_tags
  vcn_id         = var.vcn_id
}

data "oci_identity_fault_domains" "this" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
}

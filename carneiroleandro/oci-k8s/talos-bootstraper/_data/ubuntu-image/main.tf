data "oci_core_images" "this" {
  compartment_id           = var.compartment_id
  shape                    = var.shape
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
}

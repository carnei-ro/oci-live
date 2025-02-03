data "oci_core_images" "this" {
  compartment_id           = var.compartment_id
  display_name             = var.display_name
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
  shape                    = var.shape
  state                    = var.state
  sort_by                  = var.sort_by
  sort_order               = var.sort_order
}

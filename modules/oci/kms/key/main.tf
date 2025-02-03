resource "oci_kms_key" "this" {
  #Required
  compartment_id = var.compartment_id
  display_name   = var.display_name

  dynamic "key_shape" {
    for_each = [var.key_shape]

    content {
      #Required
      algorithm = key_shape.value.algorithm
      length    = key_shape.value.length
      curve_id  = key_shape.value.curve_id
    }
  }

  management_endpoint = var.management_endpoint
}

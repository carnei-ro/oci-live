resource "oci_load_balancer_load_balancer" "this" {
  compartment_id             = var.compartment_id
  display_name               = var.display_name
  shape                      = var.shape
  subnet_ids                 = var.subnet_ids
  defined_tags               = var.defined_tags
  freeform_tags              = var.freeform_tags
  ip_mode                    = var.ip_mode
  is_private                 = var.is_private
  network_security_group_ids = var.network_security_group_ids

  dynamic "reserved_ips" {
    for_each = var.reserved_ips != null && var.reserved_ips != {} ? [var.reserved_ips] : []

    content {
      id = reserved_ips.value.id
    }
  }

  dynamic "shape_details" {
    for_each = var.shape_details != null && var.shape_details != {} ? [var.shape_details] : []

    content {
      maximum_bandwidth_in_mbps = shape_details.value.maximum_bandwidth_in_mbps
      minimum_bandwidth_in_mbps = shape_details.value.minimum_bandwidth_in_mbps
    }
  }
}

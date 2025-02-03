locals {
  security_rules = {
    for sec_rule in var.security_rules : sec_rule.id => sec_rule
  }
}

resource "oci_core_network_security_group_security_rule" "this" {
  for_each = local.security_rules

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = each.value.direction
  protocol                  = each.value.protocol # "all" or ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58").

  description = try(each.value.description, null)

  destination      = try(each.value.destination, null)
  destination_type = try(each.value.destination_type, null)
  source           = try(each.value.source, null)
  source_type      = try(each.value.source_type, null)
  stateless        = try(each.value.stateless, false)

  dynamic "tcp_options" {
    for_each = length(each.value.tcp_options) > 0 ? each.value.tcp_options : []

    content {
      dynamic "destination_port_range" {
        for_each = tcp_options.value.destination_port_range != {} && tcp_options.value.destination_port_range != null ? [tcp_options.value.destination_port_range] : []

        content {
          max = destination_port_range.value.max
          min = destination_port_range.value.min
        }
      }

      dynamic "source_port_range" {
        for_each = tcp_options.value.source_port_range != {} && tcp_options.value.source_port_range != null ? [tcp_options.value.source_port_range] : []

        content {
          max = source_port_range.value.max
          min = source_port_range.value.min
        }
      }
    }
  }

  dynamic "udp_options" {
    for_each = each.value.udp_options

    content {
      dynamic "destination_port_range" {
        for_each = udp_options.value.destination_port_range != {} && udp_options.value.destination_port_range != null ? [udp_options.value.destination_port_range] : []

        content {
          max = destination_port_range.value.max
          min = destination_port_range.value.min
        }
      }

      dynamic "source_port_range" {
        for_each = udp_options.value.source_port_range != {} && udp_options.value.source_port_range != null ? [udp_options.value.source_port_range] : []

        content {
          max = source_port_range.value.max
          min = source_port_range.value.min
        }
      }
    }
  }

}

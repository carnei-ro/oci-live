output "nsg_display_name" {
  value = oci_core_network_security_group.this.display_name
}

output "nsg_id" {
  value = oci_core_network_security_group.this.id
}

output "nsg_state" {
  value = oci_core_network_security_group.this.state
}

output "instance_id" {
  description = "ocid of created instance."
  value       = oci_core_instance.this.id
}

output "private_ip" {
  description = "Private IPs of created instance."
  value       = oci_core_instance.this.private_ip
}

output "public_ip" {
  description = "Public IPs of created instance."
  value       = oci_core_instance.this.public_ip
}

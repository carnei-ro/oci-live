output "availability_domains" {
  description = "A list of availability domains."
  value       = data.oci_identity_availability_domains.this.availability_domains
}

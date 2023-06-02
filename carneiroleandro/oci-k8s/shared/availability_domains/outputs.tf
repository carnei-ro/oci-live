output "availability_domains" {
  value       = data.oci_identity_availability_domains.this.availability_domains
  description = "The list of availability_domains."
}

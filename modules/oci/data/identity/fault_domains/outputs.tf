output "fault_domains" {
  value       = data.oci_identity_fault_domains.this.fault_domains
  description = "The list of fault_domains."
}

output "compartment_id" {
  value       = oci_kms_vault.this.compartment_id
  description = "The OCID of the compartment that contains a particular vault."
}

output "crypto_endpoint" {
  value       = oci_kms_vault.this.crypto_endpoint
  description = "The service endpoint to perform cryptographic operations against. Cryptographic operations include Encrypt, Decrypt, and GenerateDataEncryptionKey operations."
}

output "defined_tags" {
  value       = oci_kms_vault.this.defined_tags
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags."
}

output "display_name" {
  value       = oci_kms_vault.this.display_name
  description = "A user-friendly name for the vault. It does not have to be unique, and it is changeable. Avoid entering confidential information."
}

output "external_key_manager_metadata_summary" {
  value       = oci_kms_vault.this.external_key_manager_metadata_summary
  description = "Summary about metadata of external key manager to be returned to the customer as a response."
}

output "freeform_tags" {
  value       = oci_kms_vault.this.freeform_tags
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
}

output "id" {
  value       = oci_kms_vault.this.id
  description = "The OCID of the vault."
}

output "is_primary" {
  value       = oci_kms_vault.this.is_primary
  description = "A Boolean value that indicates whether the Vault is primary Vault or replica Vault."
}

output "is_vault_replicable" {
  value       = oci_kms_vault.this.is_vault_replicable
  description = "A Boolean value that indicates whether the Vault has cross region replication capability. Always true for Virtual Private Vaults."
}

output "management_endpoint" {
  value       = oci_kms_vault.this.management_endpoint
  description = "The service endpoint to perform management operations against. Management operations include \"Create,\" \"Update,\" \"List,\" \"Get,\" and \"Delete\" operations."
}

output "replica_details" {
  value       = oci_kms_vault.this.replica_details
  description = "Vault replica details"
}

output "restored_from_vault_id" {
  value       = oci_kms_vault.this.restored_from_vault_id
  description = "The OCID of the vault from which this vault was restored, if it was restored from a backup file. If you restore a vault to the same region, the vault retains the same OCID that it had when you backed up the vault."
}

output "state" {
  value       = oci_kms_vault.this.state
  description = "The vault's current lifecycle state. Example: DELETED"
}

output "time_created" {
  value       = oci_kms_vault.this.time_created
  description = "The date and time this vault was created, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z"
}

output "time_of_deletion" {
  value       = oci_kms_vault.this.time_of_deletion
  description = "An optional property to indicate when to delete the vault, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z"
}

output "vault_type" {
  value       = oci_kms_vault.this.vault_type
  description = "The type of vault. Each type of vault stores the key with different degrees of isolation and has different options and pricing."
}

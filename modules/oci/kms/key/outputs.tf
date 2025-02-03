output "auto_key_rotation_details" {
  value       = oci_kms_key.this.auto_key_rotation_details
  description = "The details of auto rotation schedule for the Key being create updated or imported."
}

output "compartment_id" {
  value       = oci_kms_key.this.compartment_id
  description = "The OCID of the compartment that contains this master encryption key."
}

output "current_key_version" {
  value       = oci_kms_key.this.current_key_version
  description = "The OCID of the key version used in cryptographic operations. During key rotation, the service might be in a transitional state where this or a newer key version are used intermittently. The currentKeyVersion property is updated when the service is guaranteed to use the new key version for all subsequent encryption operations."
}

output "defined_tags" {
  value       = oci_kms_key.this.defined_tags
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags."
}

output "display_name" {
  value       = oci_kms_key.this.display_name
  description = "A user-friendly name for the key. It does not have to be unique, and it is changeable. Avoid entering confidential information."
}

output "external_key_reference_details" {
  value       = oci_kms_key.this.external_key_reference_details
  description = "Key reference data to be returned to the customer as a response."
}

output "freeform_tags" {
  value       = oci_kms_key.this.freeform_tags
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
}

output "id" {
  value       = oci_kms_key.this.id
  description = "The OCID of the key."
}

output "is_auto_rotation_enabled" {
  value       = oci_kms_key.this.is_auto_rotation_enabled
  description = "A parameter specifying whether the auto key rotation is enabled or not."
}

output "is_primary" {
  value       = oci_kms_key.this.is_primary
  description = "A Boolean value that indicates whether the Key belongs to primary Vault or replica vault."
}

output "key_shape" {
  value       = oci_kms_key.this.key_shape
  description = "The cryptographic properties of a key."
}

output "protection_mode" {
  value       = oci_kms_key.this.protection_mode
  description = "The key's protection mode indicates how the key persists and where cryptographic operations that use the key are performed. A protection mode of HSM means that the key persists on a hardware security module (HSM) and all cryptographic operations are performed inside the HSM. A protection mode of SOFTWARE means that the key persists on the server, protected by the vault's RSA wrapping key which persists on the HSM. All cryptographic operations that use a key with a protection mode of SOFTWARE are performed on the server. By default, a key's protection mode is set to HSM. You can't change a key's protection mode after the key is created or imported. A protection mode of EXTERNAL mean that the key persists on the customer's external key manager which is hosted externally outside of oracle. Oracle only hold a reference to that key. All cryptographic operations that use a key with a protection mode of EXTERNAL are performed by external key manager."
}

output "replica_details" {
  value       = oci_kms_key.this.replica_details
  description = "Key replica details"
}

output "restored_from_key_id" {
  value       = oci_kms_key.this.restored_from_key_id
  description = "The OCID of the key from which this key was restored."
}

output "state" {
  value       = oci_kms_key.this.state
  description = "The key's current lifecycle state. Example: ENABLED"
}

output "time_created" {
  value       = oci_kms_key.this.time_created
  description = "The date and time the key was created, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z"
}

output "time_of_deletion" {
  value       = oci_kms_key.this.time_of_deletion
  description = "An optional property indicating when to delete the key, expressed in RFC 3339 timestamp format. Example: 2019-04-03T21:10:29.600Z"
}

output "vault_id" {
  value       = oci_kms_key.this.vault_id
  description = "The OCID of the vault that contains this key."
}

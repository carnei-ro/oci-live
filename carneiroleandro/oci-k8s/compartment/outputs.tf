output "compartment_id" {
  description = "The OCID of the parent compartment containing the compartment."
  value       = oci_identity_compartment.this.compartment_id
}

output "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  value       = oci_identity_compartment.this.defined_tags
}

output "description" {
  description = "The description you assign to the compartment. Does not have to be unique, and it's changeable."
  value       = oci_identity_compartment.this.description
}

output "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  value       = oci_identity_compartment.this.freeform_tags
}

output "id" {
  description = "The OCID of the compartment."
  value       = oci_identity_compartment.this.id
}

output "inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = oci_identity_compartment.this.inactive_state
}

output "is_accessible" {
  description = "Indicates whether or not the compartment is accessible for the user making the request. Returns true when the user has INSPECT permissions directly on a resource in the compartment or indirectly (permissions can be on a resource in a subcompartment)."
  value       = oci_identity_compartment.this.is_accessible
}

output "name" {
  description = "The name you assign to the compartment during creation. The name must be unique across all compartments in the parent. Avoid entering confidential information."
  value       = oci_identity_compartment.this.name
}

output "state" {
  description = "The compartment's current state."
  value       = oci_identity_compartment.this.state
}

output "time_created" {
  description = "Date and time the compartment was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = oci_identity_compartment.this.time_created
}

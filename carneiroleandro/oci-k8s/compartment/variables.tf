variable "compartment_id" {
  description = "(Updatable) The OCID of the parent compartment containing the compartment."
  type        = string
  default     = null
}

variable "defined_tags" {
  description = "(Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = null
}

variable "description" {
  description = "(Updatable) The description you assign to the compartment during creation. Does not have to be unique, and it's changeable."
  type        = string
}

variable "freeform_tags" {
  description = "(Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = null
}

variable "name" {
  description = "(Updatable) The name you assign to the compartment during creation. The name must be unique across all compartments in the parent compartment. Avoid entering confidential information."
  type        = string
}

variable "enable_delete" {
  description = "If omitted or set to false the provider will implicitly import the compartment if there is a name collision, and will not actually delete the compartment on destroy or removal of the resource declaration. If set to true, the provider will throw an error on a name collision with another compartment, and will attempt to delete the compartment on destroy or removal of the resource declaration."
  type        = bool
  default     = false
}

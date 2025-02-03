variable "compartment_id" {
  description = "The OCID of the compartment containing the policy (either the tenancy or another compartment)."
  type        = string
}

variable "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "The description you assign to the policy during creation. Does not have to be unique, and it's changeable."
  type        = string
}

variable "name" {
  description = "The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed."
  type        = string
}

variable "statements" {
  description = "An array of policy statements written in the policy language. See How Policies Work and Common Policies."
  type        = list(string)
}

variable "version_date" {
  description = "The version of the policy. If null or set to an empty string, when a request comes in for authorization, the policy will be evaluated according to the current behavior of the services at that moment. If set to a particular date (YYYY-MM-DD), the policy will be evaluated according to the behavior of the services on that date."
  type        = string
  default     = null
}

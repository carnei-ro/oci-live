variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "(Required) (Updatable) The description you assign to the tag during creation."
  type        = string
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = {}
}

variable "is_cost_tracking" {
  description = "(Optional) (Updatable) Indicates whether the tag is enabled for cost tracking."
  type        = bool
  default     = false
}

variable "name" {
  description = "(Required) The name you assign to the tag during creation. This is the tag key definition. The name must be unique within the tag namespace and cannot be changed."
  type        = string
}

variable "tag_namespace_id" {
  description = "(Required) The OCID of the tag namespace."
  type        = string
}

variable "validators" {
  description = <<-EOD
    (Optional) (Updatable) Validates a definedTag value. Each validator performs validation steps in addition to the standard validation for definedTag values. For more information, see Limits on Tags.
    If you define a validator after a value has been set for a defined tag, then any updates that attempt to change the value must pass the additional validation defined by the current rule. Previously set values (even those that would fail the current validation) are not updated. You can still update other attributes to resources that contain a non-valid defined tag.
    To clear the validator call UpdateTag with DefaultTagDefinitionValidator.

    validator_type - (Required) (Updatable) Specifies the type of validation: a static value (no validation) or a list.
    values - (Applicable when validator_type=ENUM) (Updatable) The list of allowed values for a definedTag value.
  EOD
  type = list(object({
    validator_type = string
    values         = list(string)
  }))
  default = []
}


variable "is_retired" {
  description = "(Optional) (Updatable) Indicates whether the tag is retired. See Retiring Key Definitions and Namespace Definitions."
  type        = bool
  default     = false
}

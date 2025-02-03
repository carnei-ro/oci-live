# OCI - Identity - Tag

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_tag.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_tag) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | (Required) (Updatable) The description you assign to the tag during creation. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name you assign to the tag during creation. This is the tag key definition. The name must be unique within the tag namespace and cannot be changed. | `string` | n/a | yes |
| <a name="input_tag_namespace_id"></a> [tag\_namespace\_id](#input\_tag\_namespace\_id) | (Required) The OCID of the tag namespace. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `{}` | no |
| <a name="input_is_cost_tracking"></a> [is\_cost\_tracking](#input\_is\_cost\_tracking) | (Optional) (Updatable) Indicates whether the tag is enabled for cost tracking. | `bool` | `false` | no |
| <a name="input_is_retired"></a> [is\_retired](#input\_is\_retired) | (Optional) (Updatable) Indicates whether the tag is retired. See Retiring Key Definitions and Namespace Definitions. | `bool` | `false` | no |
| <a name="input_validators"></a> [validators](#input\_validators) | (Optional) (Updatable) Validates a definedTag value. Each validator performs validation steps in addition to the standard validation for definedTag values. For more information, see Limits on Tags.<br>If you define a validator after a value has been set for a defined tag, then any updates that attempt to change the value must pass the additional validation defined by the current rule. Previously set values (even those that would fail the current validation) are not updated. You can still update other attributes to resources that contain a non-valid defined tag.<br>To clear the validator call UpdateTag with DefaultTagDefinitionValidator.<br><br>validator\_type - (Required) (Updatable) Specifies the type of validation: a static value (no validation) or a list.<br>values - (Applicable when validator\_type=ENUM) (Updatable) The list of allowed values for a definedTag value. | <pre>list(object({<br>    validator_type = string<br>    values         = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_state"></a> [state](#output\_state) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

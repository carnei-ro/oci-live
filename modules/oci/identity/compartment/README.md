# OCI - Identity - Compartment

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
| [oci_identity_compartment.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_compartment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | (Updatable) The description you assign to the compartment during creation. Does not have to be unique, and it's changeable. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Updatable) The name you assign to the compartment during creation. The name must be unique across all compartments in the parent compartment. Avoid entering confidential information. | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | (Updatable) The OCID of the parent compartment containing the compartment. | `string` | `null` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `null` | no |
| <a name="input_enable_delete"></a> [enable\_delete](#input\_enable\_delete) | If omitted or set to false the provider will implicitly import the compartment if there is a name collision, and will not actually delete the compartment on destroy or removal of the resource declaration. If set to true, the provider will throw an error on a name collision with another compartment, and will attempt to delete the compartment on destroy or removal of the resource declaration. | `bool` | `false` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartment_id"></a> [compartment\_id](#output\_compartment\_id) | The OCID of the parent compartment containing the compartment. |
| <a name="output_defined_tags"></a> [defined\_tags](#output\_defined\_tags) | Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} |
| <a name="output_description"></a> [description](#output\_description) | The description you assign to the compartment. Does not have to be unique, and it's changeable. |
| <a name="output_freeform_tags"></a> [freeform\_tags](#output\_freeform\_tags) | Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} |
| <a name="output_id"></a> [id](#output\_id) | The OCID of the compartment. |
| <a name="output_inactive_state"></a> [inactive\_state](#output\_inactive\_state) | The detailed status of INACTIVE lifecycleState. |
| <a name="output_is_accessible"></a> [is\_accessible](#output\_is\_accessible) | Indicates whether or not the compartment is accessible for the user making the request. Returns true when the user has INSPECT permissions directly on a resource in the compartment or indirectly (permissions can be on a resource in a subcompartment). |
| <a name="output_name"></a> [name](#output\_name) | The name you assign to the compartment during creation. The name must be unique across all compartments in the parent. Avoid entering confidential information. |
| <a name="output_state"></a> [state](#output\_state) | The compartment's current state. |
| <a name="output_time_created"></a> [time\_created](#output\_time\_created) | Date and time the compartment was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

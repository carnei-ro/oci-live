# OCI - Identity - Dynamic Group

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
| [oci_identity_dynamic_group.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_dynamic_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the tenancy containing the group. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description you assign to the group during creation. Does not have to be unique, and it's changeable. | `string` | n/a | yes |
| <a name="input_matching_rule"></a> [matching\_rule](#input\_matching\_rule) | The matching rule to dynamically match an instance certificate to this dynamic group. For rule syntax, see Managing Dynamic Groups. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_matching_rule"></a> [matching\_rule](#output\_matching\_rule) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

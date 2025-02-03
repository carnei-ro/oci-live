# OCI - Identity - Tag Namespace

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
| [oci_identity_tag_namespace.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_tag_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the tenancy containing the tag namespace. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description you assign to the tag namespace during creation. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name you assign to the tag namespace during creation. It must be unique across all tag namespaces in the tenancy and cannot be changed. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `null` | no |
| <a name="input_is_retired"></a> [is\_retired](#input\_is\_retired) | Whether the tag namespace is retired. For more information, see Retiring Key Definitions and Namespace Definitions. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

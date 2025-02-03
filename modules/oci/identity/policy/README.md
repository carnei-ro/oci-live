# OCI - Identity - Policy

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
| [oci_identity_policy.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment containing the policy (either the tenancy or another compartment). | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description you assign to the policy during creation. Does not have to be unique, and it's changeable. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed. | `string` | n/a | yes |
| <a name="input_statements"></a> [statements](#input\_statements) | An array of policy statements written in the policy language. See How Policies Work and Common Policies. | `list(string)` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `{}` | no |
| <a name="input_version_date"></a> [version\_date](#input\_version\_date) | The version of the policy. If null or set to an empty string, when a request comes in for authorization, the policy will be evaluated according to the current behavior of the services at that moment. If set to a particular date (YYYY-MM-DD), the policy will be evaluated according to the behavior of the services on that date. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_state"></a> [state](#output\_state) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

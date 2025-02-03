# OCI - Data - Core Images

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
| [oci_core_images.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_images) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A filter to return only resources that match the given display name exactly. | `string` | `null` | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | The image's operating system. Example: Oracle Linux | `string` | `null` | no |
| <a name="input_operating_system_version"></a> [operating\_system\_version](#input\_operating\_system\_version) | The image's operating system version. Example: 7.2 | `string` | `null` | no |
| <a name="input_shape"></a> [shape](#input\_shape) | Shape name. | `string` | `null` | no |
| <a name="input_sort_by"></a> [sort\_by](#input\_sort\_by) | Sort the resources returned, by creation time or display name. Example TIMECREATED or DISPLAYNAME. | `string` | `null` | no |
| <a name="input_sort_order"></a> [sort\_order](#input\_sort\_order) | The sort order to use, either ascending (ASC) or descending (DESC). | `string` | `null` | no |
| <a name="input_state"></a> [state](#input\_state) | A filter to only return resources that match the given lifecycle state. The state value is case-insensitive. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_images"></a> [images](#output\_images) | A list of images that match the query. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

# Terraform Module for ubuntu-image

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.123.0 |

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
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | The operating system of the image. | `string` | n/a | yes |
| <a name="input_operating_system_version"></a> [operating\_system\_version](#input\_operating\_system\_version) | The operating system version of the image. | `string` | n/a | yes |
| <a name="input_shape"></a> [shape](#input\_shape) | The shape of the instance. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | The OCID of the first match. |
| <a name="output_images"></a> [images](#output\_images) | The full list of images. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

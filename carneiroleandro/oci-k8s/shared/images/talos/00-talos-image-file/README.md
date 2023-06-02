# Terraform Module for 00-talos-image-file

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.image_metadata](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.talos_image](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | The Talos version to use | `string` | n/a | yes |
| <a name="input_talos_release_url"></a> [talos\_release\_url](#input\_talos\_release\_url) | The Talos release URL to use. If not specified, this module will generate a GitHub Releases URL. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_name"></a> [artifact\_name](#output\_artifact\_name) | n/a |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | n/a |
| <a name="output_talos_version"></a> [talos\_version](#output\_talos\_version) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

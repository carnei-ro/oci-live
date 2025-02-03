# Blueprint - Talos OCI Image File

This blueprint will pull Talos image, create the `image_metadata.json` and pack it into an `oci` image at the `/tmp/` directory.

It needs `qemu-img` binary, also, `curl`, `xz` and `tar` binaries.

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

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
| <a name="input_talos_release_url"></a> [talos\_release\_url](#input\_talos\_release\_url) | The Talos release URL to use. If not specified, this module will generate a Talos Factory URL. Check https://www.talos.dev/v1.9/talos-guides/install/cloud-platforms/oracle/. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_name"></a> [artifact\_name](#output\_artifact\_name) | n/a |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | n/a |
| <a name="output_talos_version"></a> [talos\_version](#output\_talos\_version) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

# OCI - Object Storage - Object

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
| [oci_objectstorage_object.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/objectstorage_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket. Avoid entering confidential information. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Object Storage namespace used for the request. | `string` | n/a | yes |
| <a name="input_object"></a> [object](#input\_object) | The name of the object. Avoid entering confidential information. Example: test/object1.log | `string` | n/a | yes |
| <a name="input_object_source"></a> [object\_source](#input\_object\_source) | An absolute path to a file on the local system. Cannot be defined if content or source\_uri\_details is defined. | `string` | n/a | yes |
| <a name="input_content_md5"></a> [content\_md5](#input\_content\_md5) | The base-64 encoded MD5 hash of the body. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_object_name"></a> [object\_name](#output\_object\_name) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

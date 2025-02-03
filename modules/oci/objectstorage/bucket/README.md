# OCI - Object Storage - Bucket

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
| [oci_objectstorage_bucket.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/objectstorage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The ID of the compartment in which to create the bucket. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the bucket. Valid characters are uppercase or lowercase letters, numbers, hyphens, underscores, and periods. Bucket names must be unique within an Object Storage namespace. Avoid entering confidential information. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Object Storage namespace used for the request. | `string` | n/a | yes |
| <a name="input_access_type"></a> [access\_type](#input\_access\_type) | The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations. | `string` | `"NoPublicAccess"` | no |
| <a name="input_auto_tiering"></a> [auto\_tiering](#input\_auto\_tiering) | The auto tiering status on the bucket. A bucket is created with auto tiering Disabled by default. For auto tiering InfrequentAccess, objects are transitioned automatically between the 'Standard' and 'InfrequentAccess' tiers based on the access pattern of the objects. | `string` | `"Disabled"` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `null` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Set the versioning status on the bucket. By default, a bucket is created with versioning Disabled. Use this option to enable versioning during bucket creation. Objects in a version enabled bucket are protected from overwrites and deletions. Previous versions of the same object will be available in the bucket. Allowed Create values: Enabled, Disabled. Allowed Update values: Enabled, Suspended. | `string` | `"Disabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_bucket_namespace"></a> [bucket\_namespace](#output\_bucket\_namespace) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

# OCI - Compute - Image

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
| [oci_core_image.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_image) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment containing the instance you want to use as the basis for the image. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A user-friendly name for the image. It does not have to be unique, and it's changeable. Avoid entering confidential information. You cannot use a platform image name as a custom image name. | `string` | n/a | yes |
| <a name="input_image_source_details"></a> [image\_source\_details](#input\_image\_source\_details) | n/a | <pre>object({<br>    source_type    = string<br>    namespace_name = string<br>    bucket_name    = string<br>    object_name    = string<br><br>    operating_system         = string<br>    operating_system_version = string<br>    source_image_type        = string<br>  })</pre> | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `null` | no |
| <a name="input_launch_mode"></a> [launch\_mode](#input\_launch\_mode) | Specifies the configuration mode for launching virtual machine (VM) instances. The configuration modes are: NATIVE - VM instances launch with paravirtualized boot and VFIO devices. The default value for platform images. EMULATED - VM instances launch with emulated devices, such as the E1000 network driver and emulated SCSI disk controller. PARAVIRTUALIZED - VM instances launch with paravirtualized devices using VirtIO drivers. CUSTOM - VM instances launch with custom configuration settings specified in the LaunchOptions parameter. | `string` | `"PARAVIRTUALIZED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | The OCID of the image. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

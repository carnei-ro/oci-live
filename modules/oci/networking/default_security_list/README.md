# OCI - Networking - Default Security List

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
| [oci_core_default_security_list.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_default_security_list) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ingress_security_rules_source"></a> [ingress\_security\_rules\_source](#input\_ingress\_security\_rules\_source) | The source CIDR block for ingress security rules | `string` | n/a | yes |
| <a name="input_manage_default_resource_id"></a> [manage\_default\_resource\_id](#input\_manage\_default\_resource\_id) | The OCID of the `default_security_list` of the VCN | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

# Terraform Module for availability_domains

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
| [oci_identity_availability_domains.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_domains"></a> [availability\_domains](#output\_availability\_domains) | The list of availability\_domains. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

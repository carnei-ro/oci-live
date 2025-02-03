# OCI - Data - Identity - Fault Domains

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
| [oci_identity_fault_domains.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_fault_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_domain"></a> [availability\_domain](#input\_availability\_domain) | The name of the availibilityDomain. | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fault_domains"></a> [fault\_domains](#output\_fault\_domains) | The list of fault\_domains. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

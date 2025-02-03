# OCI - Networking - Network Security Group

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
| [oci_core_network_security_group.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group_security_rule.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of the compartment to contain the network security group. | `string` | n/a | yes |
| <a name="input_vcn_id"></a> [vcn\_id](#input\_vcn\_id) | The OCID of the VCN to create the network security group in. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `{}` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. | `string` | `null` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `{}` | no |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | The set of NSG rules to apply to the VCN. | <pre>list(object({<br>    id               = string<br>    description      = optional(string)<br>    destination      = optional(string)<br>    destination_type = optional(string)<br>    direction        = string<br>    icmp_options = optional(list(object({<br>      code = optional(number)<br>      type = number<br>    })))<br>    protocol    = string # "all" or ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58").<br>    source      = optional(string)<br>    source_type = optional(string)<br>    stateless   = optional(bool)<br>    tcp_options = optional(list(object({<br>      destination_port_range = optional(object({<br>        max = number<br>        min = number<br>      }))<br>      source_port_range = optional(object({<br>        max = number<br>        min = number<br>      }))<br>    })), [])<br>    udp_options = optional(list(object({<br>      destination_port_range = optional(object({<br>        max = number<br>        min = number<br>      }))<br>      source_port_range = optional(object({<br>        max = number<br>        min = number<br>      }))<br>    })), [])<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_state"></a> [state](#output\_state) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

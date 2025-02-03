# Blueprint - K8s - Load Balancer for Nodes

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
| [oci_load_balancer_backend.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_backend) | resource |
| [oci_load_balancer_backend_set.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_backend_set) | resource |
| [oci_load_balancer_listener.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_listener) | resource |
| [oci_load_balancer_load_balancer.this](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_load_balancer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_instances"></a> [backend\_instances](#input\_backend\_instances) | List of IP ADDRESS of the backend servers that will be added to the load balancer. The load balancer will distribute incoming traffic across the backend servers defined in this list. | `list(string)` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The OCID of compartment. | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: example\_load\_balancer | `string` | n/a | yes |
| <a name="input_shape"></a> [shape](#input\_shape) | A template that determines the total pre-provisioned bandwidth (ingress plus egress). To get a list of available shapes, use the ListShapes operation. Example: flexible NOTE: Starting May 2023, Fixed shapes - 10Mbps, 100Mbps, 400Mbps, 8000Mbps would be deprecated and only shape allowed would be Flexible *Note: When updating shape for a load balancer, all existing connections to the load balancer will be reset during the update process. Also 10Mbps-Micro shape cannot be updated to any other shape nor can any other shape be updated to 10Mbps-Micro. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | An array of subnet OCIDs. | `list(string)` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"} | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"} | `map(string)` | `{}` | no |
| <a name="input_ip_mode"></a> [ip\_mode](#input\_ip\_mode) | IPv6 is currently supported only in the Government Cloud. Whether the load balancer has an IPv4 or IPv6 IP address.<br>If "IPV4", the service assigns an IPv4 address and the load balancer supports IPv4 traffic.<br>If "IPV6", the service assigns an IPv6 address and the load balancer supports IPv6 traffic. | `string` | `"IPV4"` | no |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private) | Whether the load balancer has a VCN-local (private) IP address.<br>If "true", the service assigns a private IP address to the load balancer.<br>If "false", the service assigns a public IP address to the load balancer.<br>A public load balancer is accessible from the internet, depending on your VCN's security list rules. For more information about public and private load balancers, see How Load Balancing Works. | `bool` | `false` | no |
| <a name="input_listeners_and_backends"></a> [listeners\_and\_backends](#input\_listeners\_and\_backends) | List of listener and backend objects. The listener represents the interface the client connects to. The backend represents the interface that the traffic is directed to.<br>TODO: Only TCP is supported for now, fix that. | <pre>map(object({<br>    balancer_policy = string<br>    backend_port    = number<br>    listener_port   = number<br>  }))</pre> | <pre>{<br>  "http": {<br>    "backend_port": 80,<br>    "balancer_policy": "ROUND_ROBIN",<br>    "listener_port": 80<br>  }<br>}</pre> | no |
| <a name="input_network_security_group_ids"></a> [network\_security\_group\_ids](#input\_network\_security\_group\_ids) | An array of NSG OCIDs associated with this load balancer.<br>During the load balancer's creation, the service adds the new load balancer to the specified NSGs.<br><br>The benefits of using NSGs with the load balancer include:<br><br>NSGs define network security rules to govern ingress and egress traffic for the load balancer.<br>The network security rules of other resources can reference the NSGs associated with the load balancer to ensure access.<br>Example: ["ocid1.nsg.oc1.phx.unique\_ID"] | `list(string)` | `[]` | no |
| <a name="input_reserved_ips"></a> [reserved\_ips](#input\_reserved\_ips) | An array of reserved Ips. Pre-created public IP that will be used as the IP of this load balancer. This reserved IP will not be deleted when load balancer is deleted. This ip should not be already mapped to any other resource.<br>id - Ocid of the pre-created public IP that should be attached to this load balancer. The public IP will be attached to a private IP. Note If public IP resource is present in the config, the terraform plan will throw After applying this step and refreshing, the plan was not empty error, and private\_ip\_id needs to be added as an input argument to the public IP resource block or ignore from its lifecycle as shown in examples to resolve this error. | <pre>object({<br>    id = string<br>  })</pre> | `null` | no |
| <a name="input_shape_details"></a> [shape\_details](#input\_shape\_details) | The configuration details to create load balancer using Flexible shape. This is required only if shapeName is Flexible.<br><br>maximum\_bandwidth\_in\_mbps - Bandwidth in Mbps that determines the maximum bandwidth (ingress plus egress) that the load balancer can achieve. This bandwidth cannot be always guaranteed. For a guaranteed bandwidth use the minimumBandwidthInMbps parameter. The values must be between minimumBandwidthInMbps and 8000 (8Gbps).<br>minimum\_bandwidth\_in\_mbps - Bandwidth in Mbps that determines the total pre-provisioned bandwidth (ingress plus egress). The values must be between 10 and the maximumBandwidthInMbps. Example: 150 | <pre>object({<br>    maximum_bandwidth_in_mbps = number<br>    minimum_bandwidth_in_mbps = number<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_address_details"></a> [ip\_address\_details](#output\_ip\_address\_details) | The IP addresses of the load balancer. |
| <a name="output_loadbalancer_id"></a> [loadbalancer\_id](#output\_loadbalancer\_id) | The OCID of the load balancer. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->

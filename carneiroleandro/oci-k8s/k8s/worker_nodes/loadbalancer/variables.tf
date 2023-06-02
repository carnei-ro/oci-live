variable "compartment_id" {
  description = "The OCID of compartment."
  type        = string
}

variable "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = {}
}

variable "display_name" {
  description = <<-EOD
    A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: example_load_balancer
  EOD
  type        = string
}

variable "ip_mode" {
  description = <<-EOD
    IPv6 is currently supported only in the Government Cloud. Whether the load balancer has an IPv4 or IPv6 IP address.
    If "IPV4", the service assigns an IPv4 address and the load balancer supports IPv4 traffic.
    If "IPV6", the service assigns an IPv6 address and the load balancer supports IPv6 traffic.
  EOD
  type        = string
  default     = "IPV4"
}

variable "is_private" {
  description = <<-EOD
    Whether the load balancer has a VCN-local (private) IP address.
    If "true", the service assigns a private IP address to the load balancer.
    If "false", the service assigns a public IP address to the load balancer.
    A public load balancer is accessible from the internet, depending on your VCN's security list rules. For more information about public and private load balancers, see How Load Balancing Works.
  EOD
  type        = bool
  default     = false
}

variable "network_security_group_ids" {
  description = <<-EOD
    An array of NSG OCIDs associated with this load balancer.
    During the load balancer's creation, the service adds the new load balancer to the specified NSGs.

    The benefits of using NSGs with the load balancer include:

    NSGs define network security rules to govern ingress and egress traffic for the load balancer.
    The network security rules of other resources can reference the NSGs associated with the load balancer to ensure access.
    Example: ["ocid1.nsg.oc1.phx.unique_ID"]
  EOD
  type        = list(string)
  default     = []
}


variable "reserved_ips" {
  description = <<-EOD
    An array of reserved Ips. Pre-created public IP that will be used as the IP of this load balancer. This reserved IP will not be deleted when load balancer is deleted. This ip should not be already mapped to any other resource.
    id - Ocid of the pre-created public IP that should be attached to this load balancer. The public IP will be attached to a private IP. Note If public IP resource is present in the config, the terraform plan will throw After applying this step and refreshing, the plan was not empty error, and private_ip_id needs to be added as an input argument to the public IP resource block or ignore from its lifecycle as shown in examples to resolve this error.
  EOD
  type = object({
    id = string
  })
  default = null
}

variable "shape" {
  description = <<-EOD
    A template that determines the total pre-provisioned bandwidth (ingress plus egress). To get a list of available shapes, use the ListShapes operation. Example: flexible NOTE: Starting May 2023, Fixed shapes - 10Mbps, 100Mbps, 400Mbps, 8000Mbps would be deprecated and only shape allowed would be Flexible *Note: When updating shape for a load balancer, all existing connections to the load balancer will be reset during the update process. Also 10Mbps-Micro shape cannot be updated to any other shape nor can any other shape be updated to 10Mbps-Micro.
  EOD
  type        = string
}

variable "shape_details" {
  description = <<-EOD
    The configuration details to create load balancer using Flexible shape. This is required only if shapeName is Flexible.

    maximum_bandwidth_in_mbps - Bandwidth in Mbps that determines the maximum bandwidth (ingress plus egress) that the load balancer can achieve. This bandwidth cannot be always guaranteed. For a guaranteed bandwidth use the minimumBandwidthInMbps parameter. The values must be between minimumBandwidthInMbps and 8000 (8Gbps).
    minimum_bandwidth_in_mbps - Bandwidth in Mbps that determines the total pre-provisioned bandwidth (ingress plus egress). The values must be between 10 and the maximumBandwidthInMbps. Example: 150
  EOD
  type = object({
    maximum_bandwidth_in_mbps = number
    minimum_bandwidth_in_mbps = number
  })
  default = null
}

variable "subnet_ids" {
  description = <<-EOD
    An array of subnet OCIDs.
  EOD
  type        = list(string)
}

## TODO: improve this part

variable "backend_instances" {
  description = <<-EOD
    List of IP ADDRESS of the backend servers that will be added to the load balancer. The load balancer will distribute incoming traffic across the backend servers defined in this list.
  EOD
  type        = list(string)
}

variable "listeners_and_backends" {
  description = <<-EOD
    List of listener and backend objects. The listener represents the interface the client connects to. The backend represents the interface that the traffic is directed to.
    TODO: Only TCP is supported for now, fix that.
  EOD
  type = map(object({
    balancer_policy = string
    backend_port    = number
    listener_port   = number
  }))
  default = {
    http = {
      balancer_policy = "ROUND_ROBIN"
      backend_port    = 80
      listener_port   = 80
    }
  }
}

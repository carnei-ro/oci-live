variable "compartment_id" {
  description = "The OCID of the compartment to contain the network security group."
  type        = string
}

variable "display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  type        = string
  default     = null
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

variable "vcn_id" {
  description = "The OCID of the VCN to create the network security group in."
  type        = string
}

variable "security_rules" {
  description = "The set of NSG rules to apply to the VCN."
  type = list(object({
    id               = string
    description      = optional(string)
    destination      = optional(string)
    destination_type = optional(string)
    direction        = string
    icmp_options = optional(list(object({
      code = optional(number)
      type = number
    })))
    protocol    = string # "all" or ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58").
    source      = optional(string)
    source_type = optional(string)
    stateless   = optional(bool)
    tcp_options = optional(list(object({
      destination_port_range = optional(object({
        max = number
        min = number
      }))
      source_port_range = optional(object({
        max = number
        min = number
      }))
    })), [])
    udp_options = optional(list(object({
      destination_port_range = optional(object({
        max = number
        min = number
      }))
      source_port_range = optional(object({
        max = number
        min = number
      }))
    })), [])
  }))
  default = []
}

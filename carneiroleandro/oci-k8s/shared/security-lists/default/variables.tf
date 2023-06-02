variable "manage_default_resource_id" {
  type        = string
  description = "The OCID of the `default_security_list` of the VCN"
}

variable "ingress_security_rules_source" {
  type        = string
  description = "The source CIDR block for ingress security rules"
}

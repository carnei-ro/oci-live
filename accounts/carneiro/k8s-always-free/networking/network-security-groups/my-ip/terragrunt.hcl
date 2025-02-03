terraform {
  source = "${get_repo_root()}/modules/oci/networking/network_security_group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "vcn" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/vcn"
}

dependency "my_external_ip" {
  config_path = "${get_repo_root()}/accounts/carneiro/_data/networking/my_external_ip"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  vcn_id         = dependency.vcn.outputs.vcn_id
  display_name   = "my-ip"
  security_rules = flatten([
    [
      {
        id               = "egress"
        description      = "Managed by oci-live"
        stateless        = false
        direction        = "EGRESS"
        protocol         = "all"
        destination      = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
      },
    ],
    ([for destination_port in ["22", "80", "443", "6443", "50000"] :
      {
        id          = "tcp-${destination_port}"
        description = "Managed by oci-live"
        stateless   = false
        direction   = "INGRESS"
        protocol    = "6"
        source      = format("%s/32", jsondecode(dependency.my_external_ip.outputs.response_body).Answer[0].data)
        source_type = "CIDR_BLOCK"
        tcp_options = [{
          destination_port_range = {
            min = destination_port
            max = destination_port
          }
        }]
      }
    ])
  ])
}

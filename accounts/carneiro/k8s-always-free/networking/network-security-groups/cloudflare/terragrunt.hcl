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

dependency "cloudflare_ips" {
  config_path = "${get_repo_root()}/accounts/carneiro/_data/networking/cloudflare_ipv4"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  vcn_id         = dependency.vcn.outputs.vcn_id
  display_name   = "cloudflare"
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
    ([for cloudflare_cidr in jsondecode(dependency.cloudflare_ips.outputs.response_body).result.ipv4_cidrs :
      {
        id          = cloudflare_cidr
        description = "Managed by oci-live"
        stateless   = false
        direction   = "INGRESS"
        protocol    = "6"
        source      = cloudflare_cidr
        source_type = "CIDR_BLOCK"
        tcp_options = [{
          destination_port_range = {
            min = "80"
            max = "80"
          }
        }]
      }
    ])
  ])
}

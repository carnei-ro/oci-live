terraform {
  source = "${get_repo_root()}//modules/_blueprints/k8s/lb4nodes"
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

dependency "cloudflare_nsg" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/network-security-groups/cloudflare"
}

dependency "my_ip_nsg" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/network-security-groups/my-ip"
}

dependency "node_0" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/instances/node-0"
}

dependency "node_1" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/instances/node-1"
}

dependency "node_2" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/instances/node-2"
}

inputs = {
  display_name = "k8s-nodes-lb"
  shape        = "flexible"

  listeners_and_backends = {
    k8s-nodes = {
      balancer_policy = "ROUND_ROBIN"
      backend_port    = 32080
      listener_port   = 80
    }
    talos = {
      balancer_policy = "ROUND_ROBIN"
      backend_port    = 50000
      listener_port   = 50000
    }
  }

  subnet_ids = [dependency.vcn.outputs.subnet_id.public]

  ip_mode    = "IPV4"
  is_private = false
  network_security_group_ids = [
    dependency.cloudflare_nsg.outputs.id,
    dependency.my_ip_nsg.outputs.id,
  ]

  shape_details = {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  backend_instances = [
    dependency.node_0.outputs.private_ip,
    dependency.node_1.outputs.private_ip,
    dependency.node_2.outputs.private_ip,
  ]

  compartment_id = dependency.compartment.outputs.id
}

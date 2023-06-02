terraform {
  before_hook "patch_terraform_cloud_workspace_execution_mode" {
    commands = ["apply", "plan"]
    execute = [
      "sh",
      "-c",
      <<-EOC
        ${local.repo_root}/_hack/patch-terraform-cloud-workspace-execution-mode.sh \
        ${local.terraform_cloud.organization} \
        ${local.terraform_cloud_workspace}
      EOC
    ]
  }
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_root                 = get_repo_root()
  terraform_cloud           = read_terragrunt_config(find_in_parent_folders("terraform_cloud.hcl")).locals
  terraform_cloud_workspace = sha256(path_relative_to_include())
}

dependency "compartment" {
  config_path = "../../../compartment"
}

dependency "vcn" {
  config_path = "../../../shared/vcn"
}

dependency "cloudflare_sg" {
  config_path = "../../../shared/security-groups/cloudflare"
}

dependency "my_external_ip_sg" {
  config_path = "../../../shared/security-groups/my-external-ip"
}

dependency "worker_node_0" {
  config_path = "../../worker_nodes/worker-0"
}

dependency "worker_node_1" {
  config_path = "../../worker_nodes/worker-1"
}

dependency "worker_node_2" {
  config_path = "../../worker_nodes/worker-2"
}

inputs = {
  display_name = "k8s-nodes-lb"
  shape        = "flexible"

  listeners_and_backends = {
    http = {
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
    dependency.cloudflare_sg.outputs.nsg_id,
    dependency.my_external_ip_sg.outputs.nsg_id,
  ]

  shape_details = {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }

  backend_instances = [
    dependency.worker_node_0.outputs.private_ip,
    dependency.worker_node_1.outputs.private_ip,
    dependency.worker_node_2.outputs.private_ip,
  ]

  compartment_id = dependency.compartment.outputs.id
}

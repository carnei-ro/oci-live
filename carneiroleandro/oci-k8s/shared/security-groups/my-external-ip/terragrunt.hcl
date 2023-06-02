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
  config_path = "../../vcn"
}

dependency "my_external_ip" {
  config_path = "../_external-data/my-external-ip"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  vcn_id         = dependency.vcn.outputs.vcn_id
  display_name   = "my-external-ip"
  security_rules = flatten([
    [
      {
        id               = "egress"
        description      = "Managed by Terraform"
        stateless        = false
        direction        = "EGRESS"
        protocol         = "all"
        destination      = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
      },
    ],
    ([for ingress_port in [22, 80, 443, 6443, 50000] :
      {
        id          = format("%s_%s", tostring(ingress_port), dependency.my_external_ip.outputs.ipv4_cidrs[0])
        description = "Managed by Terraform"
        stateless   = false
        direction   = "INGRESS"
        protocol    = "6"
        source      = dependency.my_external_ip.outputs.ipv4_cidrs[0]
        source_type = "CIDR_BLOCK"
        tcp_options = [{
          destination_port_range = {
            min = ingress_port
            max = ingress_port
          }
        }]
      }
    ]),
  ])
}

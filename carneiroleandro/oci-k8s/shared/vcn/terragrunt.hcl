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

  source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn.git//?ref=v3.5.4"
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
  config_path = "../../compartment"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id

  vcn_cidrs        = ["10.0.0.0/16"]
  vcn_display_name = "oci-k8s"

  enable_ipv6 = false

  create_internet_gateway = true
  create_nat_gateway      = true

  subnets = {
    public = {
      cidr_block = "10.0.16.0/22"
      type       = "public"
      dns_label  = "public"
    }
    private = {
      cidr_block = "10.0.8.0/21"
      type       = "private"
      dns_label  = "private"
    }
  }
}

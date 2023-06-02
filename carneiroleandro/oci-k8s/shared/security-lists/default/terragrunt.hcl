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


dependency "vcn" {
  config_path = "../../vcn"
}

inputs = {
  manage_default_resource_id    = dependency.vcn.outputs.vcn_all_attributes.default_security_list_id
  ingress_security_rules_source = dependency.vcn.outputs.vcn_all_attributes.cidr_block
}

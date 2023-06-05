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
  config_path = "../../../../compartment"
}

dependency "dynamic_group" {
  config_path = "../../dynamic-group"
}

dependency "my_external_ip_nsg" {
  config_path = "../../../../shared/security-groups/my-external-ip"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  name           = "manage-nsg"
  description    = "Allow Kubernetes nodes to manage network security groups"

  statements = [
    # TODO: policy based on tag is not working
    # format("Allow dynamic-group %s to manage network-security-groups in compartment %s where target.resource.tag.Custom-Tags.ManagedBy='Dynamic-Group/%s'",
    #   dependency.dynamic_group.outputs.name,
    #   dependency.compartment.outputs.name,
    #   dependency.dynamic_group.outputs.name,
    # )
    format("Allow dynamic-group %s to manage network-security-groups in compartment %s",
      dependency.dynamic_group.outputs.name,
      dependency.compartment.outputs.name
    )
  ]
}

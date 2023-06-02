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

  tenancy = read_terragrunt_config(find_in_parent_folders("tenancy.hcl")).locals
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
  compartment_id = local.tenancy.tenancy_ocid
  name           = "k8s-nodes"
  description    = "Kubernetes Nodes Instances"

  matching_rule = format(
    "Any{Any {%s}}", join(", ", [
      format("instance.id = '%s'", dependency.worker_node_0.outputs.instance_id),
      format("instance.id = '%s'", dependency.worker_node_1.outputs.instance_id),
      format("instance.id = '%s'", dependency.worker_node_2.outputs.instance_id),
    ])
  )
}

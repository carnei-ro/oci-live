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

dependency "compartment" {
  config_path = "../../../../compartment"
}

dependency "objectstorage_namespace" {
  config_path = "../01-objectstorage-namespace"
}

locals {
  repo_root                 = get_repo_root()
  terraform_cloud           = read_terragrunt_config(find_in_parent_folders("terraform_cloud.hcl")).locals
  terraform_cloud_workspace = sha256(path_relative_to_include())

  bucket_name = "talos-image"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  namespace      = dependency.objectstorage_namespace.outputs.namespace
  name           = local.bucket_name
  access_type    = "NoPublicAccess"
  auto_tiering   = "InfrequentAccess"
  versioning     = "Disabled"
}

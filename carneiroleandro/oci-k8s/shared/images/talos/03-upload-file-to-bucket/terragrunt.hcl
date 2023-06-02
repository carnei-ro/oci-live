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

dependency "image_file" {
  config_path = "../00-talos-image-file"
}

dependency "bucket" {
  config_path = "../02-bucket"
}

locals {
  repo_root                 = get_repo_root()
  terraform_cloud           = read_terragrunt_config(find_in_parent_folders("terraform_cloud.hcl")).locals
  terraform_cloud_workspace = sha256(path_relative_to_include())
}

inputs = {
  bucket        = dependency.bucket.outputs.bucket_name
  namespace     = dependency.bucket.outputs.bucket_namespace
  object        = dependency.image_file.outputs.artifact_name
  object_source = format("../00-talos-image-file/%s", dependency.image_file.outputs.artifact_name)
  content_md5   = filemd5(format("../00-talos-image-file/%s", dependency.image_file.outputs.artifact_name))
}

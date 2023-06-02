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

dependency "image_file" {
  config_path = "../00-talos-image-file"
}

dependency "image_object" {
  config_path = "../03-upload-file-to-bucket"
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
  compartment_id = dependency.compartment.outputs.id

  display_name = dependency.image_file.outputs.display_name
  launch_mode  = "PARAVIRTUALIZED"

  image_source_details = {
    source_type    = "objectStorageTuple"
    bucket_name    = dependency.bucket.outputs.bucket_name
    namespace_name = dependency.bucket.outputs.bucket_namespace
    object_name    = dependency.image_object.outputs.object_name

    #Optional
    operating_system         = "Talos"
    operating_system_version = dependency.image_file.outputs.talos_version
    source_image_type        = "QCOW2"
  }
}

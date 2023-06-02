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

  personal = read_terragrunt_config(find_in_parent_folders("personal_information.hcl")).locals
}

dependency "vcn" {
  config_path = "../../shared/vcn"
}


inputs = {
  # This are "personal" values, you should change them, or leave it blank.
  additional_sans            = local.personal.additional_sans
  k8s_service_account_issuer = local.personal.k8s_service_account_issuer

  k8s_version             = "1.27.2"
  context_name            = "oci-k8s"
  k8s_pod_subnet_cidr     = "100.96.0.0/11"
  k8s_service_subnet_cidr = "100.64.0.0/13"

  # Do not edit this, unless you have a Load Balancer for the ControlPlanes.
  k8s_apiserver_endpoint = format("https://%s:6443", cidrhost(dependency.vcn.outputs.subnet_all_attributes.public.cidr_block, 100))
}

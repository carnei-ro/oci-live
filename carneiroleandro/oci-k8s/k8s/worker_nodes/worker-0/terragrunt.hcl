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

dependency "compartment" {
  config_path = "../../../compartment"
}

dependency "vcn" {
  config_path = "../../../shared/vcn"
}

dependency "availability_domains" {
  config_path = "../../../shared/availability_domains"
}

dependency "fault_domains" {
  config_path = "../../../shared/fault_domains"
}

dependency "cloudflare_sg" {
  config_path = "../../../shared/security-groups/cloudflare"
}

dependency "image" {
  config_path = "../../../shared/images/talos/04-image"
}

dependency "talos_config" {
  config_path = "../../talos-config-files"
}

inputs = {
  display_name = "worker-0"
  shape        = "VM.Standard.A1.Flex"

  shape_config = {
    ocpus         = 1
    memory_in_gbs = 6
  }

  metadata = {
    ssh_authorized_keys = local.personal.ssh_authorized_keys
    user_data           = dependency.talos_config.outputs.worker_yaml_b64
  }

  source_details = {
    source_type = "image"
    source_id   = dependency.image.outputs.image_id
  }

  create_vnic_details = {
    assign_public_ip = false
    subnet_id        = dependency.vcn.outputs.subnet_all_attributes.private.id
    private_ip       = cidrhost(dependency.vcn.outputs.subnet_all_attributes.private.cidr_block, 100)
    nsg_ids = [
      dependency.cloudflare_sg.outputs.nsg_id,
    ]
  }

  compartment_id      = dependency.compartment.outputs.id
  availability_domain = dependency.availability_domains.outputs.availability_domains[0].name
  fault_domain        = dependency.fault_domains.outputs.fault_domains[0].name
}

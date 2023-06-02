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
  config_path = "../../compartment"
}

dependency "vcn" {
  config_path = "../../shared/vcn"
}

dependency "availability_domains" {
  config_path = "../../shared/availability_domains"
}

dependency "fault_domains" {
  config_path = "../../shared/fault_domains"
}

dependency "my_external_ip_sg" {
  config_path = "../../shared/security-groups/my-external-ip"
}

dependency "cloud_init" {
  config_path = "../_data/cloud-init"
}

dependency "image" {
  config_path = "../_data/ubuntu-image"
}


inputs = {
  display_name = "talos-bootstraper"
  shape        = "VM.Standard.E2.1.Micro"

  shape_config = {
    ocpus         = 1
    memory_in_gbs = 1
  }

  metadata = {
    ssh_authorized_keys = local.personal.ssh_authorized_keys
    user_data           = dependency.cloud_init.outputs.rendered
  }

  source_details = {
    source_type = "image"
    source_id   = dependency.image.outputs.image_id
  }

  create_vnic_details = {
    assign_public_ip = true
    subnet_id        = dependency.vcn.outputs.subnet_all_attributes.public.id
    private_ip       = cidrhost(dependency.vcn.outputs.subnet_all_attributes.public.cidr_block, 200)
    nsg_ids = [
      dependency.my_external_ip_sg.outputs.nsg_id,
    ]
  }

  compartment_id      = dependency.compartment.outputs.id
  availability_domain = dependency.availability_domains.outputs.availability_domains[0].name
  fault_domain        = dependency.fault_domains.outputs.fault_domains[2].name
}

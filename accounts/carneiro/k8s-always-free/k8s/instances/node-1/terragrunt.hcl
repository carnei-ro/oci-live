terraform {
  source = "${get_repo_root()}//modules/oci/compute/instance"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "vcn" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/vcn"
}

dependency "availability_domains" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/identity/availability_domains"
}

dependency "fault_domains" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/identity/fault_domains"
}

dependency "cloudflare_nsg" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/network-security-groups/cloudflare"
}

dependency "image" {
  # config_path = "${get_repo_root()}/shared/images/talos/04-image"
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/oci-images/ubuntu-24.04"
}

dependency "talos_config" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/talos/config-files"
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl", find_in_parent_folders(".empty.hcl"))).locals
}

inputs = {
  display_name = "node-1"
  shape        = "VM.Standard.A1.Flex"

  shape_config = {
    ocpus         = 1
    memory_in_gbs = 6
  }

  metadata = {
    ssh_authorized_keys = try(local.common.ssh_authorized_keys)
    user_data           = dependency.talos_config.outputs.worker_yaml_b64
  }

  source_details = {
    source_type = "image"
    # source_id   = dependency.image.outputs.image_id
    source_id = dependency.image.outputs.images[0].id
  }

  create_vnic_details = {
    assign_public_ip = false
    subnet_id        = dependency.vcn.outputs.subnet_all_attributes.private.id
    private_ip       = cidrhost(dependency.vcn.outputs.subnet_all_attributes.private.cidr_block, 101)
    nsg_ids = [
      dependency.cloudflare_nsg.outputs.id,
    ]
  }

  compartment_id      = dependency.compartment.outputs.id
  availability_domain = dependency.availability_domains.outputs.availability_domains[0].name
  fault_domain        = dependency.fault_domains.outputs.fault_domains[1].name
}

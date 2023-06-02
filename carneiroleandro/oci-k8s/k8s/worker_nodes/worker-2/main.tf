resource "oci_core_instance" "this" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain

  display_name = var.display_name

  shape = var.shape

  dynamic "shape_config" {
    for_each = var.shape_config != null && var.shape_config != {} ? [var.shape_config] : []

    content {
      baseline_ocpu_utilization = try(shape_config.value.baseline_ocpu_utilization, null)
      memory_in_gbs             = try(shape_config.value.memory_in_gbs, null)
      nvmes                     = try(shape_config.value.nvmes, null)
      ocpus                     = try(shape_config.value.ocpus, null)
    }
  }

  dynamic "source_details" {
    for_each = var.source_details != null && var.source_details != {} ? [var.source_details] : []

    content {
      boot_volume_size_in_gbs = try(source_details.value.boot_volume_size_in_gbs, null)
      boot_volume_vpus_per_gb = try(source_details.value.boot_volume_vpus_per_gb, null)
      kms_key_id              = try(source_details.value.kms_key_id, null)
      source_id               = try(source_details.value.source_id, null)
      source_type             = try(source_details.value.source_type, null)
    }
  }

  dynamic "create_vnic_details" {
    for_each = var.create_vnic_details != null && var.create_vnic_details != {} ? [var.create_vnic_details] : []

    content {
      assign_private_dns_record = try(create_vnic_details.value.assign_private_dns_record, null)
      assign_public_ip          = try(create_vnic_details.value.assign_public_ip, null)
      defined_tags              = try(create_vnic_details.value.defined_tags, null)
      display_name              = try(create_vnic_details.value.display_name, null)
      freeform_tags             = try(create_vnic_details.value.freeform_tags, null)
      hostname_label            = try(create_vnic_details.value.hostname_label, null)
      nsg_ids                   = try(create_vnic_details.value.nsg_ids, null)
      private_ip                = try(create_vnic_details.value.private_ip, null)
      skip_source_dest_check    = try(create_vnic_details.value.skip_source_dest_check, null)
      subnet_id                 = try(create_vnic_details.value.subnet_id, null)
      vlan_id                   = try(create_vnic_details.value.vlan_id, null)
    }
  }

  dynamic "launch_options" {
    for_each = var.launch_options != null && var.launch_options != {} ? [var.launch_options] : []

    content {
      boot_volume_type                    = try(launch_options.value.boot_volume_type, null)
      firmware                            = try(launch_options.value.firmware, null)
      is_consistent_volume_naming_enabled = try(launch_options.value.is_consistent_volume_naming_enabled, null)
      is_pv_encryption_in_transit_enabled = try(launch_options.value.is_pv_encryption_in_transit_enabled, null)
      network_type                        = try(launch_options.value.network_type, null)
      remote_data_volume_type             = try(launch_options.value.remote_data_volume_type, null)
    }
  }

  fault_domain      = var.fault_domain
  extended_metadata = var.extended_metadata
  metadata = {
    ssh_authorized_keys = try(var.metadata.ssh_authorized_keys, null)
    user_data           = try(var.metadata.user_data, null)
  }


  agent_config {
    are_all_plugins_disabled = false
    is_management_disabled   = false
    is_monitoring_disabled   = false

    plugins_config {
      #Required
      desired_state = "ENABLED"
      name          = "Bastion"
    }
    plugins_config {
      #Required
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
  }

}

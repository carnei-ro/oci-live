variable "compartment_id" {
  description = "The OCID of the compartment."
  type        = string
}

variable "availability_domain" {
  description = "The availability domain of the instance."
  type        = string
}

variable "display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  type        = string
  default     = null
}

variable "shape" {
  description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
  type        = string
}

variable "shape_config" {
  description = <<-EOD
    The shape configuration requested for the instance.
    If the parameter is provided, the instance is created with the resources that you specify. If some properties are missing or the entire parameter is not provided, the instance is created with the default configuration values for the shape that you specify.
    Each shape only supports certain configurable values. If the values that you provide are not valid for the specified shape, an error is returned.

    baseline_ocpu_utilization - The baseline OCPU utilization for a subcore burstable VM instance. Leave this attribute blank for a non-burstable instance, or explicitly specify non-burstable with BASELINE_1_1.
      The following values are supported:
      BASELINE_1_8 - baseline usage is 1/8 of an OCPU.
      BASELINE_1_2 - baseline usage is 1/2 of an OCPU.
      BASELINE_1_1 - baseline usage is an entire OCPU. This represents a non-burstable instance.
    memory_in_gbs - (Optional) (Updatable) The total amount of memory available to the instance, in gigabytes.
    nvmes - (Optional) (Updatable) The number of NVMe drives to be used for storage. A single drive has 6.8 TB available.
    ocpus - (Optional) (Updatable) The total number of OCPUs available to the instance.
  EOD
  type = object({
    baseline_ocpu_utilization = optional(string)
    memory_in_gbs             = optional(number)
    nvmes                     = optional(number)
    ocpus                     = optional(number)
  })
  default = {}
}

variable "source_details" {
  description = <<-EOD
    boot_volume_size_in_gbs - (Applicable when source_type=image) (Updatable) The size of the boot volume in GBs. Minimum value is 50 GB and maximum value is 32,768 GB (32 TB).
    boot_volume_vpus_per_gb - (Applicable when source_type=image) The number of volume performance units (VPUs) that will be applied to this volume per GB, representing the Block Volume service's elastic performance options. See Block Volume Performance Levels for more information.
    Allowed values:
      10: Represents Balanced option.
      20: Represents Higher Performance option.
      30-120: Represents the Ultra High Performance option.
      For volumes with the auto-tuned performance feature enabled, this is set to the default (minimum) VPUs/GB.
    kms_key_id - (Applicable when source_type=image) The OCID of the Vault service key to assign as the master encryption key for the boot volume.
    source_id - (Required) The OCID of an image or a boot volume to use, depending on the value of source_type.
    source_type - (Required) The source type for the instance. Use image when specifying the image OCID. Use bootVolume when specifying the boot volume OCID.
  EOD
  type = object({
    boot_volume_size_in_gbs = optional(number)
    boot_volume_vpus_per_gb = optional(number)
    kms_key_id              = optional(string)
    source_id               = optional(string)
    source_type             = optional(string)
  })
  default = {}
}

variable "create_vnic_details" {
  description = <<-EOD
    Contains properties for a VNIC. You use this object when creating the primary VNIC during instance launch or when creating a secondary VNIC. For more information about VNICs, see Virtual Network Interface Cards (VNICs).

      assign_private_dns_record - (Optional) Whether the VNIC should be assigned a DNS record. If set to false, no DNS record registion for the VNIC; if set to true, DNS record will be registered. The default value is true. Example: true. If you specify a hostnameLabel, the assignPrivateDnsRecord is require to be set to true.
      assign_public_ip - (Optional) (Updatable) Whether the VNIC should be assigned a public IP address. Defaults to whether the subnet is public or private. If not set and the VNIC is being created in a private subnet (that is, where prohibitPublicIpOnVnic = true in the Subnet), then no public IP address is assigned. If not set and the subnet is public (prohibitPublicIpOnVnic = false), then a public IP address is assigned. If set to true and prohibitPublicIpOnVnic = true, an error is returned.
        Note: This public IP address is associated with the primary private IP on the VNIC. For more information, see IP Addresses.
        Note: There's a limit to the number of public IPs a VNIC or instance can have. If you try to create a secondary VNIC with an assigned public IP for an instance that has already reached its public IP limit, an error is returned. For information about the public IP limits, see Public IP Addresses.
        Example: false
        If you specify a vlanId, then assignPublicIp must be set to false. See Vlan.
      defined_tags - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {"Operations.CostCenter": "42"}
      display_name - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
      freeform_tags - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {"Department": "Finance"}
      hostname_label - (Optional) (Updatable) The hostname for the VNIC's primary private IP. Used for DNS. The value is the hostname portion of the primary private IP's fully qualified domain name (FQDN) (for example, bminstance1 in FQDN bminstance1.subnet123.vcn1.oraclevcn.com). Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123. The value appears in the Vnic object and also the PrivateIp object returned by ListPrivateIps and GetPrivateIp.
        For more information, see DNS in Your Virtual Cloud Network.
        When launching an instance, use this hostnameLabel instead of the deprecated hostnameLabel in LaunchInstanceDetails. If you provide both, the values must match.
        Example: bminstance1
        If you specify a vlanId, the hostnameLabel cannot be specified. VNICs on a VLAN can not be assigned a hostname. See Vlan.
      nsg_ids - (Optional) (Updatable) A list of the OCIDs of the network security groups (NSGs) to add the VNIC to. For more information about NSGs, see NetworkSecurityGroup.
        If a vlanId is specified, the nsgIds cannot be specified. The vlanId indicates that the VNIC will belong to a VLAN instead of a subnet. With VLANs, all VNICs in the VLAN belong to the NSGs that are associated with the VLAN. See Vlan.
      private_ip - (Optional) A private IP address of your choice to assign to the VNIC. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns a private IP address from the subnet. This is the VNIC's primary private IP address. The value appears in the Vnic object and also the PrivateIp object returned by ListPrivateIps and GetPrivateIp.
        If you specify a vlanId, the privateIp cannot be specified. See Vlan.
        Example: 10.0.3.3
      skip_source_dest_check - (Optional) (Updatable) Whether the source/destination check is disabled on the VNIC. Defaults to false, which means the check is performed. For information about why you would skip the source/destination check, see Using a Private IP as a Route Target.
        If you specify a vlanId, the skipSourceDestCheck cannot be specified because the source/destination check is always disabled for VNICs in a VLAN. See Vlan.
        Example: true
      subnet_id - (Optional) The OCID of the subnet to create the VNIC in. When launching an instance, use this subnetId instead of the deprecated subnetId in LaunchInstanceDetails. At least one of them is required; if you provide both, the values must match.
        If you are an Oracle Cloud VMware Solution customer and creating a secondary VNIC in a VLAN instead of a subnet, provide a vlanId instead of a subnetId. If you provide both a vlanId and subnetId, the request fails.
      vlan_id - (Optional) Provide this attribute only if you are an Oracle Cloud VMware Solution customer and creating a secondary VNIC in a VLAN. The value is the OCID of the VLAN. See Vlan.
        Provide a vlanId instead of a subnetId. If you provide both a vlanId and subnetId, the request fails.
  EOD
  type = object({
    assign_private_dns_record = optional(bool)
    assign_public_ip          = optional(bool)
    defined_tags              = optional(map(string))
    display_name              = optional(string)
    freeform_tags             = optional(map(string))
    hostname_label            = optional(string)
    nsg_ids                   = optional(list(string))
    private_ip                = optional(string)
    skip_source_dest_check    = optional(bool)
    subnet_id                 = optional(string)
    vlan_id                   = optional(string)
  })
  default = {}
}

variable "launch_options" {
  description = <<-EOD
    Options for tuning the compatibility and performance of VM shapes. The values that you specify override any default values.

    boot_volume_type - (Optional) (Updatable) Emulation type for the boot volume.
      ISCSI - ISCSI attached block storage device.
      SCSI - Emulated SCSI disk.
      IDE - Emulated IDE disk.
      VFIO - Direct attached Virtual Function storage. This is the default option for local data volumes on platform images.
      PARAVIRTUALIZED - Paravirtualized disk. This is the default for boot volumes and remote block storage volumes on platform images.
    firmware - (Optional) Firmware used to boot VM. Select the option that matches your operating system.
      BIOS - Boot VM using BIOS style firmware. This is compatible with both 32 bit and 64 bit operating systems that boot using MBR style bootloaders.
      UEFI_64 - Boot VM using UEFI style firmware compatible with 64 bit operating systems. This is the default for platform images.
    is_consistent_volume_naming_enabled - (Optional) Whether to enable consistent volume naming feature. Defaults to false.
    is_pv_encryption_in_transit_enabled - (Optional) (Updatable) Use this for update operation only. This field is Deprecated during create. For create use isPvEncryptionInTransitEnabled in LaunchInstanceDetails.
    network_type - (Optional) (Updatable) Emulation type for the physical network interface card (NIC).
      E1000 - Emulated Gigabit ethernet controller. Compatible with Linux e1000 network driver.
      VFIO - Direct attached Virtual Function network controller. This is the networking type when you launch an instance using hardware-assisted (SR-IOV) networking.
      PARAVIRTUALIZED - VM instances launch with paravirtualized devices using VirtIO drivers.
    remote_data_volume_type - (Optional) Emulation type for volume.
      ISCSI - ISCSI attached block storage device.
      SCSI - Emulated SCSI disk.
      IDE - Emulated IDE disk.
      VFIO - Direct attached Virtual Function storage. This is the default option for local data volumes on platform images.
      PARAVIRTUALIZED - Paravirtualized disk. This is the default for boot volumes and remote block storage volumes on platform images.
  EOD
  type = object({
    boot_volume_type                    = optional(string)
    firmware                            = optional(string)
    is_consistent_volume_naming_enabled = optional(bool)
    is_pv_encryption_in_transit_enabled = optional(bool)
    network_type                        = optional(string)
    remote_data_volume_type             = optional(string)
  })
  default = {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = null
    is_pv_encryption_in_transit_enabled = null
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
}

variable "fault_domain" {
  description = <<-EOD
    The name of the fault domain the instance is running in.
    A fault domain is a grouping of hardware and infrastructure within an availability domain. Each availability domain contains three fault domains. Fault domains let you distribute your instances so that they are not on the same physical hardware within a single availability domain. A hardware failure or Compute hardware maintenance that affects one fault domain does not affect instances in other fault domains.
    If you do not specify the fault domain, the system selects one for you.
    Example: FAULT-DOMAIN-1
  EOD
  type        = string
  default     = null
}

variable "extended_metadata" {
  description = <<-EOD
    Additional metadata key/value pairs that you provide. They serve the same purpose and functionality as fields in the metadata object.
    They are distinguished from metadata fields in that these can be nested JSON objects (whereas metadata fields are string/string maps only).
    Input in terraform is the same as metadata but allows nested metadata if you pass a valid JSON string as a value. See the example below.
  EOD
  type        = any
  default     = {}
}

variable "metadata" {
  description = <<-EOD
  Custom metadata key/value pairs that you provide, such as the SSH public key required to connect to the instance.
  A metadata service runs on every launched instance. The service is an HTTP endpoint listening on 169.254.169.254. You can use the service to:

  ssh_authorized_keys - Provide one or more public SSH keys to be included in the ~/.ssh/authorized_keys file for the default user on the instance. Use a newline character to separate multiple keys. The SSH keys must be in the format necessary for the authorized_keys file, as shown in the example below.
  user_data - Provide your own base64-encoded data to be used by Cloud-Init to run custom scripts or provide custom Cloud-Init configuration. For information about how to take advantage of user data, see the Cloud-Init Documentation.
  EOD
  type = object({
    ssh_authorized_keys = optional(string)
    user_data           = optional(string)
  })
  default = {}
}

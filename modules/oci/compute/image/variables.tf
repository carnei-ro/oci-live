variable "display_name" {
  type        = string
  description = "A user-friendly name for the image. It does not have to be unique, and it's changeable. Avoid entering confidential information. You cannot use a platform image name as a custom image name."
}

variable "launch_mode" {
  type        = string
  description = "Specifies the configuration mode for launching virtual machine (VM) instances. The configuration modes are: NATIVE - VM instances launch with paravirtualized boot and VFIO devices. The default value for platform images. EMULATED - VM instances launch with emulated devices, such as the E1000 network driver and emulated SCSI disk controller. PARAVIRTUALIZED - VM instances launch with paravirtualized devices using VirtIO drivers. CUSTOM - VM instances launch with custom configuration settings specified in the LaunchOptions parameter."
  default     = "PARAVIRTUALIZED"
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment containing the instance you want to use as the basis for the image."
}

variable "image_source_details" {
  type = object({
    source_type    = string
    namespace_name = string
    bucket_name    = string
    object_name    = string

    operating_system         = string
    operating_system_version = string
    source_image_type        = string
  })
}

variable "freeform_tags" {
  description = "(Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = null
}

variable "defined_tags" {
  description = "(Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = null
}

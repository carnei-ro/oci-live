variable "key_shape" {
  description = <<-EOF
  The cryptographic properties of a key.

  algorithm - (Required) The algorithm used by a key's key versions to encrypt or decrypt. Only AES algorithm is supported for External keys.
  curve_id - (Optional) Supported curve IDs for ECDSA keys.
  length - (Required) The length of the key in bytes, expressed as an integer. Supported values include the following:
  EOF
  type = object({
    algorithm = string
    curve_id  = optional(string, null)
    length    = string
  })
}

variable "compartment_id" {
  type        = string
  description = "(Updatable) The OCID of the compartment where you want to create the master encryption key."
}

variable "management_endpoint" {
  type        = string
  description = "The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations. See Vault Management endpoint."
}

variable "display_name" {
  type        = string
  description = "(Updatable) A user-friendly name for the key. It does not have to be unique, and it is changeable. Avoid entering confidential information."
}

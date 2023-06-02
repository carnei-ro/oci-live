variable "compartment_id" {
  type        = string
  description = "The ID of the compartment in which to create the bucket."
}

variable "namespace" {
  type        = string
  description = "The Object Storage namespace used for the request."
}

variable "name" {
  type        = string
  description = "The name of the bucket. Valid characters are uppercase or lowercase letters, numbers, hyphens, underscores, and periods. Bucket names must be unique within an Object Storage namespace. Avoid entering confidential information."
}

variable "access_type" {
  type        = string
  description = " The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations."
  default     = "NoPublicAccess"
}

variable "auto_tiering" {
  type        = string
  description = "The auto tiering status on the bucket. A bucket is created with auto tiering Disabled by default. For auto tiering InfrequentAccess, objects are transitioned automatically between the 'Standard' and 'InfrequentAccess' tiers based on the access pattern of the objects."
  default     = "Disabled"
}

variable "versioning" {
  type        = string
  description = "Set the versioning status on the bucket. By default, a bucket is created with versioning Disabled. Use this option to enable versioning during bucket creation. Objects in a version enabled bucket are protected from overwrites and deletions. Previous versions of the same object will be available in the bucket. Allowed Create values: Enabled, Disabled. Allowed Update values: Enabled, Suspended."
  default     = "Disabled"
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

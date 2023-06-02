variable "bucket" {
  type        = string
  description = "The name of the bucket. Avoid entering confidential information."
}

variable "namespace" {
  type        = string
  description = "The Object Storage namespace used for the request."
}

variable "object" {
  type        = string
  description = "The name of the object. Avoid entering confidential information. Example: test/object1.log"
}

variable "object_source" {
  type        = string
  description = "An absolute path to a file on the local system. Cannot be defined if content or source_uri_details is defined."
}

variable "content_md5" {
  type        = string
  description = "The base-64 encoded MD5 hash of the body."
  default     = null
}

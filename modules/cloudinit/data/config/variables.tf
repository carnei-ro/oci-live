variable "parts" {
  description = <<-EOD
    List of blocks type which adds a file to the generated cloud-init configuration. Use multiple part blocks to specify multiple files, which will be included in order of declaration in the final MIME document.
      content - (String) Body content for the part.
      content_type - (String) A MIME-style content type to report in the header for the part. Defaults to text/plain.
      filename - (String) A filename to report in the header for the part.
      merge_type - (String) A value for the X-Merge-Type header of the part, to control cloud-init merging behavior.
  EOD
  type = list(object({
    content      = string
    content_type = optional(string)
    filename     = optional(string)
    merge_type   = optional(string)
  }))
}

variable "base64_encode" {
  description = <<-EOD
    Specify whether or not to base64 encode the rendered output. Defaults to true, and cannot be disabled if gzip is true.
  EOD
  type        = bool
  default     = true
}

variable "boundary" {
  description = <<-EOD
    Specify the Writer's default boundary separator. Defaults to MIMEBOUNDARY.
  EOD
  type        = string
  default     = "MIMEBOUNDARY"
}

variable "gzip" {
  description = <<-EOD
    Specify whether or not to gzip the rendered output. Defaults to true.
  EOD
  type        = bool
  default     = true
}

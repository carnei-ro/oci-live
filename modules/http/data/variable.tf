variable "url" {
  description = "The URL for the request. Supported schemes are http and https."
  type        = string
}

variable "ca_cert_pem" {
  description = "Certificate data of the Certificate Authority (CA) in PEM (RFC 1421) format."
  type        = string
  default     = null
}

variable "insecure" {
  description = "Disables verification of the server's certificate chain and hostname. Defaults to false"
  type        = bool
  default     = false
}

variable "method" {
  description = "The HTTP Method for the request. Allowed methods are a subset of methods defined in RFC7231 namely, GET, HEAD, and POST. POST support is only intended for read-only URLs, such as submitting a search."
  type        = string
  default     = null
}

variable "request_body" {
  description = "The request body as a string."
  type        = string
  default     = null
}

variable "request_headers" {
  description = "A map of request header field names and values."
  type        = map(string)
  default     = {}
}

variable "request_timeout_ms" {
  description = "(Number) The request timeout in milliseconds."
  type        = number
  default     = null
}

variable "retry" {
  description = <<-EOF
    Retry request configuration. By default there are no retries. Configuring this block will result in retries if an error is returned by the client (e.g., connection errors) or if a 5xx-range (except 501) status code is received."

    `attempts` - (Number) The number of times the request is to be retried. For example, if 2 is specified, the request will be tried a maximum of 3 times.
    `max_delay_ms` - (Number) The maximum delay between retry requests in milliseconds.
    `min_delay_ms` - (Number) The minimum delay between retry requests in milliseconds.
  EOF
  default     = {}
  type = object({
    attempts     = optional(number, null)
    max_delay_ms = optional(number, null)
    min_delay_ms = optional(number, null)
  })
}

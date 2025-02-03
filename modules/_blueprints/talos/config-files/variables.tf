variable "k8s_version" {
  description = "The version of Kubernetes to install"
  type        = string
  default     = "1.32.1"
}

variable "context_name" {
  description = "The name of the context to create"
  type        = string
  default     = "oci-k8s"
}

variable "k8s_apiserver_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  type        = string
}

variable "additional_sans" {
  description = "Additional SANs to add to the TLS certificate."
  type        = list(string)
  default     = []
}

variable "k8s_pod_subnet_cidr" {
  description = "The CIDR block for the pod subnet"
  type        = string
  default     = "100.96.0.0/11"
}

variable "k8s_service_subnet_cidr" {
  description = "The CIDR block for the service subnet"
  type        = string
  default     = "100.64.0.0/13"
}

variable "k8s_service_account_issuer" {
  description = "The issuer for the service account token"
  type        = string
  default     = ""
}

variable "k8s_service_account_private_key_b64" {
  description = "The private key for signing all the the service account's tokens encoded in base64. If not provided, a new key will be generated."
  type        = string
  default     = null
}

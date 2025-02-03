variable "compartment_id" {
  type        = string
  description = "(Updatable) The OCID of the compartment where you want to create this vault."
}

variable "display_name" {
  type        = string
  description = "(Updatable) A user-friendly name for the vault. It does not have to be unique, and it is changeable. Avoid entering confidential information."
}

variable "vault_type" {
  type        = string
  description = "The type of vault to create. Each type of vault stores the key with different degrees of isolation and has different options and pricing."
}

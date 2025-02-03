# ------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ------------------------------------------------------------------------------

# Version constraints
terraform_binary              = "tofu"
terraform_version_constraint  = ">= 1.9.0"
terragrunt_version_constraint = ">= 0.72.5"

# Local aliases for improved maintainability
locals {
  gitlab_username   = "carnei-ro"
  gitlab_project_id = "53959949"
  gitlab_password   = get_env("GITLAB_TOKEN")

  # To encrypt a value:
  #  echo -n 'some_value_here' | openssl pkeyutl -encrypt -pubin -inkey ~/.oci/sessions/DEFAULT/oci_api_key_public.pem | base64
  gitlab_secrets_to_fetch = [
    "MY_ENCRYPTED_VARIABLE",
  ]

  repo_root = get_repo_root()
  iac_repo  = "oci-live"
  iac_path  = path_relative_to_include()

  tf_state_name = sha256(format("%s/%s", local.iac_repo, local.iac_path))

  # Automatically load tenancy variables
  tenancy_vars = read_terragrunt_config(find_in_parent_folders("tenancy.hcl", find_in_parent_folders(".empty.hcl"))).locals
  # Automatically load compartment variables
  compartment_vars = read_terragrunt_config(find_in_parent_folders("compartment.hcl", find_in_parent_folders(".empty.hcl"))).locals
}

# Copy the first .tool-versions file found in the directory hierarchy when blueprint has none,
# otherwise skip and use one defined in blueprint.
# NOTE: requires ASDF-VM (https://asdf-vm.com)
generate "tool_versions" {
  path      = ".tool-versions"
  if_exists = "skip"
  contents  = file(find_in_parent_folders(".tool-versions"))
}

# Generate the OCI provider config
generate "oci_provider" {
  path      = "_tg_oci_provider.tofu"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "oci" {
      tenancy_ocid     = "${local.tenancy_vars.tenancy_ocid}"
      region           = "${local.tenancy_vars.region}"
      user_ocid        = "${local.tenancy_vars.user_ocid}"
      fingerprint      = "${local.tenancy_vars.fingerprint}"
      private_key_path = "${local.tenancy_vars.private_key_path}"
    }
  EOF
}

# Fetch secret from GITLAB CI/CD Variables
generate "gitlab_secrets" {
  path      = "_gitlab_secrets.tofu"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    data "gitlab_project_variable" "gitlab_secret" {
      for_each = toset(${replace(jsonencode(local.gitlab_secrets_to_fetch), "\\\"", "\"")})

      project = "${local.gitlab_project_id}"
      key     = each.key
    }

    locals {
      secrets = {
        %{for key in toset(local.gitlab_secrets_to_fetch)~}
        ${key} = rsadecrypt(data.gitlab_project_variable.gitlab_secret["${key}"].value, file("${local.tenancy_vars.private_key_path}"))
        %{endfor~}
      }
    }
  EOF
}

generate "encryption" {
  path      = "_encryption.tofu"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
  variable "state_encryption_passphrase" {
    type        = string
    description = "The passphrase to use for encrypting the state file"
  }

  terraform {
    encryption {
      # method "unencrypted" "migrate" {}

      key_provider "pbkdf2" "key" {
        passphrase = var.state_encryption_passphrase
      }

      method "aes_gcm" "aes" {
        keys = key_provider.pbkdf2.key
      }

      state {
        method = method.aes_gcm.aes
        # fallback {
        #   method = method.unencrypted.migrate
        # }
        enforced = true
      }

      plan {
        method = method.aes_gcm.aes
        # fallback {
        #   method = method.unencrypted.migrate
        # }
        enforced = true
      }
    }
  }

  EOF
}

# Generate the Backend config
generate "backend" {
  path      = "_backend.tofu"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      backend "http" {
        address        = "${format("https://gitlab.com/api/v4/projects/%s/terraform/state/%s", local.gitlab_project_id, local.tf_state_name)}"
        lock_address   = "${format("https://gitlab.com/api/v4/projects/%s/terraform/state/%s/lock", local.gitlab_project_id, local.tf_state_name)}"
        unlock_address = "${format("https://gitlab.com/api/v4/projects/%s/terraform/state/%s/lock", local.gitlab_project_id, local.tf_state_name)}"
        username       = "${local.gitlab_username}"
        password       = "${local.gitlab_password}"
        lock_method    = "POST"
        unlock_method  = "DELETE"
        retry_wait_min = "5"
      }
    }
  EOF
}

# ------------------------------------------------------------------------------
# AUTO RETRY
# The following errors are well known and should be retried.
# See https://terragrunt.gruntwork.io/docs/features/auto-retry/
# ------------------------------------------------------------------------------

errors {
  # Retry block for transient errors
  retry "transient_errors" {
    retryable_errors   = [".*Error: transient network issue.*"]
    max_attempts       = 3
    sleep_interval_sec = 5
  }
}

# ------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.tenancy_vars,
  local.compartment_vars,
  {
    freeform_tags = merge(
      {
        created_by    = "terragrunt"
        iac_repo      = local.iac_repo
        iac_path      = local.iac_path
        tf_state_name = local.tf_state_name
      },
      try(local.tenancy_vars.freeform_tags, {}),
      try(local.compartment_vars.freeform_tags, {}),
    )
  }
)

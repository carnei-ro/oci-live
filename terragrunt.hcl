# ------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ------------------------------------------------------------------------------

# Version constraints
terraform_version_constraint  = ">= 1.4.6"
terragrunt_version_constraint = ">= 0.45.0"

# Local aliases for improved maintainability
locals {
  repo_root      = get_repo_root()
  workspace_name = path_relative_to_include()

  # Automatically load account and region-level variables
  tenancy_vars = read_terragrunt_config(find_in_parent_folders("tenancy.hcl")).locals

  # Automatically Terraform Cloud variables
  terraform_cloud = read_terragrunt_config(find_in_parent_folders("terraform_cloud.hcl")).locals

  # Extract the variables we need for easy access
  tenancy_ocid = local.tenancy_vars.tenancy_ocid
  region       = local.tenancy_vars.region
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
  path      = "_tg-oci-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "oci" {
      # alias = "this"

      tenancy_ocid     = "${local.tenancy_ocid}"
      region           = "${local.region}"
      user_ocid        = "${local.tenancy_vars.user_ocid}"
      fingerprint      = "${local.tenancy_vars.fingerprint}"
      private_key_path = "${local.tenancy_vars.private_key_path}"
    }
  EOF
}

# Generate the Backend config
generate "backend" {
  path      = "_backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      # required_providers {
      #   oci = {
      #     source  = "oracle/oci"
      #     version = "~> 4.0"
      #   }
      # }
      cloud {
        organization = "${local.terraform_cloud.organization}"

        workspaces {
          name = "${sha256(path_relative_to_include())}"
        }
      }
    }
  EOF
}

# ------------------------------------------------------------------------------
# AUTO RETRY
# The following errors are well known and should be retried.
# See https://terragrunt.gruntwork.io/docs/features/auto-retry/
# ------------------------------------------------------------------------------

retry_max_attempts       = 3
retry_sleep_interval_sec = 5

retryable_errors = [
  # Intermittent network issues
  "(?s).*Error installing provider.*tcp.*connection reset by peer.*",
  "(?s).*read:.*software caused connection abort.*",
  "(?s).*ssh_exchange_identification.*Connection closed by remote host.*",
]

# ------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.tenancy_vars,
  local.terraform_cloud,
  {
    freeform_tags = {
      CreatedBy = "terraform"
      iac_repo  = "oci-live"
      iac_path  = path_relative_to_include()
    }
  },
)

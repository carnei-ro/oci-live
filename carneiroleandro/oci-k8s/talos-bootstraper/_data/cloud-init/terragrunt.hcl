terraform {
  before_hook "patch_terraform_cloud_workspace_execution_mode" {
    commands = ["apply", "plan"]
    execute = [
      "sh",
      "-c",
      <<-EOC
        ${local.repo_root}/_hack/patch-terraform-cloud-workspace-execution-mode.sh \
        ${local.terraform_cloud.organization} \
        ${local.terraform_cloud_workspace}
      EOC
    ]
  }
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_root                 = get_repo_root()
  terraform_cloud           = read_terragrunt_config(find_in_parent_folders("terraform_cloud.hcl")).locals
  terraform_cloud_workspace = sha256(path_relative_to_include())
}

dependency "talos_config" {
  config_path = "../../../k8s/talos-config-files"
}

dependency "talos" {
  config_path = "../../../shared/images/talos/00-talos-image-file"
}

dependency "controlplane" {
  config_path = "../../../k8s/controlplane/instance-0"
}

inputs = {
  base64_encode = true
  gzip          = false

  parts = [{
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = <<-YAML
      #cloud-config

      runcmd:
        - |
          export TALOSFLAGS="--talosconfig talosconfig --nodes ${dependency.controlplane.outputs.private_ip} --endpoints ${dependency.controlplane.outputs.private_ip}"
          curl -sSlL -o talosctl https://github.com/siderolabs/talos/releases/download/${dependency.talos.outputs.talos_version}/talosctl-linux-amd64
          chmod +x talosctl
          echo '${dependency.talos_config.outputs.talosconfig_b64}' | base64 -d | tee talosconfig
          ./talosctl $TALOSFLAGS bootstrap
          ./talosctl $TALOSFLAGS kubeconfig /tmp/
          chown ubuntu:ubuntu /tmp/kubeconfig
          sed -i /tmp/kubeconfig \
            -e 's/${dependency.controlplane.outputs.private_ip}/${dependency.controlplane.outputs.public_ip}/g' \
            -e 's/certificate-authority-data/# certificate-authority-data/g' \
            -e '/certificate-authority-data/a \    insecure-skip-tls-verify: true'
      YAML
  }]
}

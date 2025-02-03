terraform {
  source = "${get_repo_root()}//modules/cloudinit/data/config"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "talos_config" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/talos/config-files"
}

dependency "talos_image" {
  config_path = "${get_repo_root()}/accounts/carneiro/_data/oci-images/talos-1.9.3"
}

dependency "controlplane" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/instances/controlplane-0"
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
          curl -sSlL -o talosctl https://github.com/siderolabs/talos/releases/download/${dependency.talos_image.outputs.talos_version}/talosctl-linux-amd64
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

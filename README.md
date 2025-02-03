# Oracle Cloud Infrastructure (OCI) Live

## Prerequisites

- GitLab Repo & Personal Access Token: You will need a GitLab repository to store your Terraform states. You will also need a personal access token to authenticate with GitLab. Edit the `root.hcl` file changing the **gitlab_username** and **gitlab_project_id** variables to match your GitLab username and project ID respectively. Export your personal access token as an environment variable `GITLAB_TOKEN`.
- Passphrase: You will need a passphrase to encrypt your Terraform states. Export your passphrase as an environment variable `TF_VAR_state_encryption_passphrase`. You can generate a passphrase using the following command: `LC_ALL=C tr -dc 'A-Za-z0-9*#@' < /dev/urandom | head -c 32`. **BE CAREFUL: DO NOT LOSE YOUR PASSPHRASE. YOU WILL NOT BE ABLE TO DECRYPT YOUR TERRAFORM STATES WITHOUT IT.**
- Binaries:
  - curl
  - xz (xz-utils)
  - tar
  - qemu-img
  - tofu
  - terragrunt
  - talosctl

## Optional Flags

To keep the log as it used to be, set the environment variables:

- TERRAGRUNT_LOG_FORMAT="bare"
- TERRAGRUNT_FORWARD_TF_STDOUT="true"

## Oracle Cloud

Create a free Account on [Oracle Cloud](https://signup.cloud.oracle.com/?sourceType=_ref_coc-asset-opcSignIn&language=en_US?redirect_uri=https://cloud.oracle.com/).

- After creating the account, go to "Profile" > "My Profile".
- Scroll down the page and go to `API Keys` at the `Resources` section.
- Click on `Generate API key pair`, then `Download private key`.
- Save the file as `oci_api_key.pem` at `~/.ssh/oci_api_key.pem`, also, change the permissions to read only `chmod 0400 ~/.ssh/oci_api_key.pem`.
- Finally, click at the `Add` button and copy the config file.

## Folder Structure

Create a directory with the name of your Oracle Tenancy, in my case `carneiro` inside `accounts` directory. Inside your tenancy directory, create file named `tenancy.hcl` with content describing the Tenancy OCID, Region and API Key information (TODO: make a better approach for the login part).

```hcl
locals {
  private_key_path = "~/.ssh/oci_api_key.pem"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  fingerprint      = "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:ef"

  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  region       = "sa-vinhedo-1"
}
```

## Running

To create all the resources on Oracle Cloud, run the following commands inside the Tenancy directory (`carneiro` in my case):

```bash
terragrunt run-all --terragrunt-non-interactive plan
# If all good, run:
terragrunt run-all --terragrunt-non-interactive apply
```

After the resources are created, you can access the Kubernetes. The `kubeconfig` file will be available at `/tmp/kubeconfig` from the **talos-bootstraper** instance. To get it, run:

```bash
export INSTANCE_IP="<You need to enter the public IP here>"
until scp -o "StrictHostKeyChecking=no" ubuntu@${INSTANCE_IP}:/tmp/kubeconfig /tmp/kubeconfig; do
  sleep 1
done
kubectl --kubeconfig /tmp/kubeconfig get nodes
```

## Caveats

- To figure out the "Terraform Cloud Workspace" to a specific path execute: `echo -n $PWD | sed "s|$(git rev-parse --show-toplevel)/||g" | sha256sum | awk '{print $1}'`
- To edit the cluster, ssh to the **talos-bootstraper** instance as ubuntu user, become root and run `/talosctl --talosconfig=/talosconfig --nodes 10.0.16.100 --endpoints 10.0.16.100 edit machineconfig --mode=reboot`. This will reboot the instance and apply the changes.
- To enable **all** `feature-gates` and `apis` (runtime-config), edit add the following to the machineconfig:

```yaml
machine:
  kubelet:
    extraArgs:
      feature-gates: AllBeta=true #"AllAlpha=true,AllBeta=true"

cluster:
  apiServer:
    extraArgs:
      runtime-config: "api/all=true"
      feature-gates: AllBeta=true #"AllAlpha=true,AllBeta=true"
```

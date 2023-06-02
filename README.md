# OCI Live

Disclaimers:

- This is a work in progress. :warning:
- Unfortunatelly, the "community official" modules for Oracle Cloud Infrastructure (OCI) are not as good as the AWS ones. So, I decided to create my own modules to create a Kubernetes cluster on OCI. I don't have a repository for the modules yet, so you'll find a lot of `main.tf`, `variables.tf`, `outputs.tf` aside the `terragrunt.hcl` file.
- Every new "workspace" in Terraform Cloud automatically is set to "Remote", this repo contains a workaround to set it to "Local" by default. It utilizes the [Terragrunt Hooks](https://terragrunt.gruntwork.io/docs/features/hooks/), the script inside the `_hack` directory, and the credentials from `~/.terraform.d/credentials.tfrc.json`.
- Talos Image is not available at Oracle Cloud by default, so I created a workaround to download it from the GitHub Releases and upload it to the Oracle Cloud Object Storage, then importing as "custom image".

## Requirements

Binaries:

- curl
- jq
- terraform (>= 1.4.6)
- terragrunt (>= 0.45.0)
- talosctl (>= 1.4.5)
- tar
- xz (xz-utils)

## State Backend

I'm using Terraform Cloud as our state backend. This will allow us to collaborate on the same state file and also keep a history of changes, and it is FREE!.

Create a free Account on [Terraform Cloud](https://app.terraform.io/public/signup/account) and create a new organization (Start from Scratch). In my case, my organization is `carneiroleandro`.

<!-- Then create a new workspace, select the `CLI-Driven Workflow` option and name it `oci`, then click on `Create Workspace`. At the next page, click on the `Settings`, set the `Execution Mode` to "**Local**" and hit "Save settings" button. -->

Now run `terraform login`, it will generate a `User Token` at the web browser. You can set description as `terragrunt` and set `No expiration`. :warning: This is not secure, you should rotate your secrets! Now copy the token and paste it at the terminal you ran `terraform login` command.

```bash
Generate a token using your browser, and copy-paste it into this prompt.

Terraform will store the token in plain text in the following file
for use by subsequent commands:
    /Users/leo/.terraform.d/credentials.tfrc.json

Token for app.terraform.io:
  Enter a value:


Retrieved token for user carneiroleandro
```

## Oracle Cloud

Create a free Account on [Oracle Cloud](https://signup.cloud.oracle.com/?sourceType=_ref_coc-asset-opcSignIn&language=en_US?redirect_uri=https://cloud.oracle.com/).

- After creating the account, go to "Profile" > "My Profile".
- Scroll down the page and go to `API Keys` at the `Resources` section.
- Click on `Generate API key pair`, then `Download private key`.
- Save the file as `oci_api_key.pem` at `~/.ssh/oci_api_key.pem`, also, change the permissions to read only `chmod 0400 ~/.ssh/oci_api_key.pem`.
- Finally, click at the `Add` button and copy the config file.

## Folder Structure

Create a directory with the name of your Oracle Tenancy, in my case `carneiroleandro`. Inside this directory, create file named `tenancy.hcl` with  content describing the Tenancy OCID, Region and API Key informations (TODO: make a better approach for the login part).

```hcl
locals {
  private_key_path = "~/.ssh/oci_api_key.pem"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaknvtj7nncaungeropkwvphj3gbegpubsjkgv3jw3hchehfwcwq5a"
  fingerprint      = "01:8a:eb:e2:b5:af:78:d2:77:9c:fd:c4:fe:64:33:ef"

  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  region       = "sa-vinhedo-1"
}
```

Create the `terraform_cloud.hcl` file inside the `carneiroleandro` directory with information about your Terraform Cloud account. In my case, my Oracle Tenancy has the same name of my Terraform Cloud organization, in you case, it can be different.

```hcl
locals {
  organization   = "carneiroleandro"
  workspace_name = "oci"
}
```

Edit the `terragrunt.hcl` at the root of this repository changing the value of the `oci_tenancy_name` variable to your Oracle Tenancy name.

## Forking this repo

To this repo be useful after forking it, you need to:

- rename the `carneiroleandro` directory to your Oracle Tenancy name
- edit the `terragrunt.hcl` at the root of this repository changing the value of the `oci_tenancy_name` variable to your Oracle Tenancy name.
- edit the `tenancy.hcl` file (inside the Tenancy directory) with your Tenancy OCID, Region and API Key informations
- edit the `terraform_cloud.hcl` file (inside the Tenancy directory) with your Terraform Cloud organization and workspace name
- edit the `personal_information.hcl` file (inside the Tenancy directory) with your personal information

## Running

To create all the resources on Oracle Cloud, run the following commands inside the Tenancy directory (`carneiroleandro` in my case):

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

locals {
  ssh_authorized_keys = join("\n", [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKQnQ32Z6ssiQLu2IgV1vImnejik3mYHPsD05ShcEQ4Pw2T+6NUJ+8IJv0tVmpP3tuizmvXGJJyH2T97ZzfPZ1sjJtjbg/mE2moa89IQARzNsyIcqgGvHuXftZ+HH7ox0uOQRrkJ5ajXkaaYVN6yNZBsBUQHioRgFeJ9B3Yl8sJjqHe7co5nixGXnM0hRozev5PWc14sQUxeMsRqYiDtpTHBREuIEhj0guEC1Y2PxjmS+yiVagksstV1cWgzDpFPAgAfvBg+w7dS40RFYZw6vgRNYb0BLLmTr8XyNJGpHCKY2V6eDQDclQu4fFv+Yg9U0PgXvpewiPDRYLRHF1RKzt"
  ])

  # This are "personal" values, you should change them, or leave it blank.
  additional_sans            = ["https://api.oci-k8s.carnei.ro:6443"]
  k8s_service_account_issuer = "https://carnei-ro.github.io/k8s-aws-iam/oci-k8s"
}

machine:
  time:
    disabled: false
    servers:
      - 169.254.169.254

cluster:
%{if k8s_service_account_issuer != "" }
  apiServer:
    extraArgs:
      service-account-issuer: ${k8s_service_account_issuer}
%{endif}
  serviceAccount:
    key: ${k8s_service_account_private_key_b64}

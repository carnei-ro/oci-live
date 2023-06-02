machine:
  time:
    disabled: false
    servers:
      - 169.254.169.254

%{if k8s_service_account_issuer != "" }
cluster:
  apiServer:
    extraArgs:
      service-account-issuer: ${k8s_service_account_issuer}
%{endif}

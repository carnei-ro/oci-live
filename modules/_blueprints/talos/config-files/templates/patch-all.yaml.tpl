cluster:
  network:
    podSubnets:
      - ${k8s_pod_subnet_cidr}
    serviceSubnets:
      - ${k8s_service_subnet_cidr}

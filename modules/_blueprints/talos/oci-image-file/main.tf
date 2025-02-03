locals {
  talos_release_url = var.talos_release_url != null ? var.talos_release_url : format("https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/%s/oracle-arm64.raw.xz", var.talos_version)
}

resource "local_file" "image_metadata" {
  filename = "image_metadata.json"
  content = jsonencode({
    additionalMetadata = {
      shapeCompatibilities = [
        {
          internalShapeName = "VM.Standard.A1.Flex"
          memoryConstraints = null
          ocpuConstraints   = null
        },
      ]
    }
    externalLaunchOptions = {
      bootVolumeType                = "PARAVIRTUALIZED"
      consistentVolumeNamingEnabled = true
      firmware                      = "UEFI_64"
      launchOptionsSource           = "PARAVIRTUALIZED"
      localDataVolumeType           = "PARAVIRTUALIZED"
      networkType                   = "PARAVIRTUALIZED"
      pvAttachmentVersion           = 2
      pvEncryptionInTransitEnabled  = true
      remoteDataVolumeType          = "PARAVIRTUALIZED"
    }
    imageCapabilityData    = null
    imageCapsFormatVersion = null
    operatingSystem        = "Talos"
    operatingSystemVersion = replace(var.talos_version, "v", "")
    version                = 2
  })
}


resource "null_resource" "talos_image" {
  triggers = {
    on_version_change = var.talos_version
  }

  provisioner "local-exec" {
    command = <<-EOF
      rm -f talos-arm64-${var.talos_version}.oci
      curl -sSlLo talos-arm64-${var.talos_version}.raw.xz ${local.talos_release_url}
      xz -d talos-arm64-${var.talos_version}.raw.xz
      qemu-img convert -f raw -O qcow2 talos-arm64-${var.talos_version}.raw oracle-arm64.qcow2
      tar zcf /tmp/talos-arm64-${var.talos_version}.oci oracle-arm64.qcow2 image_metadata.json
      rm -f oracle-arm64.qcow2 image_metadata.json talos-arm64-${var.talos_version}.raw
    EOF
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm /tmp/talos-arm64-*.oci"
  }
  depends_on = [local_file.image_metadata]
}

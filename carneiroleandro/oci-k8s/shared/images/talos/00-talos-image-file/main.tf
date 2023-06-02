locals {
  talos_release_url = var.talos_release_url != null ? var.talos_release_url : format("https://github.com/siderolabs/talos/releases/download/%s/oracle-arm64.qcow2.xz", var.talos_version)
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
    operatingSystemVersion = var.talos_version
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
      curl -sSlLo talos-arm64-${var.talos_version}.qcow2.xz ${local.talos_release_url}
      xz -d talos-arm64-${var.talos_version}.qcow2.xz
      tar zcf talos-arm64-${var.talos_version}.oci talos-arm64-${var.talos_version}.qcow2 image_metadata.json
      rm -f talos-arm64-${var.talos_version}.qcow2 image_metadata.json
    EOF
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm talos-arm64-*.oci"
  }
  depends_on = [local_file.image_metadata]
}

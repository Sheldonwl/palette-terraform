data "spectrocloud_registry_pack" "registry" {
  name = "Public Repo"
}

data "spectrocloud_pack" "eks" {
  name    = "amazon-linux-eks"
  version = "1.0.0"
  registry_uid = data.spectrocloud_registry_pack.registry.id
}

data "spectrocloud_pack" "cni" {
  name    = "cni-aws-vpc-eks"
  version = "1.0"
  registry_uid = data.spectrocloud_registry_pack.registry.id
}

data "spectrocloud_pack" "k8" {
  name    = "kubernetes-eks"
  version = "1.27"
  registry_uid = data.spectrocloud_registry_pack.registry.id
}

data "spectrocloud_pack" "efscsi" {
  name    = "csi-aws-efs"
  version = "1.5.6"
  registry_uid = data.spectrocloud_registry_pack.registry.id
}
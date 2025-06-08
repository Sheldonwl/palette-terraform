terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.1"
    }
  }
  required_version = ">= 1.0.0"
}

# The provider will automatically use environment variables from openstack-rc file
provider "openstack" {}

# Create a single VM with ephemeral volume and Ubuntu image
resource "openstack_compute_instance_v2" "ubuntu_vm" {
  name            = var.vm_name_prefix
  image_id        = data.openstack_images_image_v2.ubuntu_image.id
  flavor_name     = data.openstack_compute_flavor_v2.flavor.name
  key_pair        = var.key_pair_name
  user_data       = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    ssh_public_key      = var.ssh_public_key
    ubuntu_password_hash = var.ubuntu_password_hash
    github_username     = var.github_username
  })
  config_drive    = true
  
  # Configure ephemeral disk
  block_device {
    uuid                  = data.openstack_images_image_v2.ubuntu_image.id
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }
  
  network {
    uuid = data.openstack_networking_network_v2.network.id
  }
}
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

# Create multiple VMs with ephemeral storage directly from the image
resource "openstack_compute_instance_v2" "edge_vm" {
  count           = var.vm_count
  name            = "${var.vm_name_prefix}-${count.index + 1}"
  image_id        = data.openstack_images_image_v2.edge_image.id
  flavor_name     = data.openstack_compute_flavor_v2.flavors.name
  key_pair        = var.key_pair_name
  user_data       = data.local_file.user_data.content
  config_drive    = true
  
  network {
    uuid = data.openstack_networking_network_v2.add_network.id
  }
}
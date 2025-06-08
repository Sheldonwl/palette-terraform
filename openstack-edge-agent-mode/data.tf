# Data sources for OpenStack resources

# Get the Ubuntu image based on the variable
data "openstack_images_image_v2" "ubuntu_image" {
  name        = var.image_name
  most_recent = true
}

# Get available flavor based on the variable
data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

# Get the network
data "openstack_networking_network_v2" "network" {
  name = var.vm_network
}

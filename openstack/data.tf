# Data sources for OpenStack resources

# Get the image based on the variable
data "openstack_images_image_v2" "edge_image" {
  name        = var.image_name
  most_recent = true
}

# Get available flavors based on the variable
data "openstack_compute_flavor_v2" "flavors" {
  name = var.flavor_name
}

# Get the network
data "openstack_networking_network_v2" "add_network" {
  name = var.vm_network
}

# Read the user-data file
data "local_file" "user_data" {
  filename = "${path.module}/user-data"
}

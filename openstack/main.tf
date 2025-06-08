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

# Get current project/tenant information
data "openstack_identity_auth_scope_v3" "scope" {
  name = "current"
}

# Get all networks
data "openstack_networking_network_v2" "networks" {
  # This will get all networks
}

# Get all ports - this is how we'll find instances
data "openstack_networking_port_ids_v2" "all_ports" {}

# For each port, get details
data "openstack_networking_port_v2" "port_details" {
  for_each = toset(data.openstack_networking_port_ids_v2.all_ports.ids)
  port_id  = each.value
}

# Process the ports to extract instance information
locals {
  # Filter ports that are attached to instances (device_owner starts with "compute:")
  instance_ports = { for id, port in data.openstack_networking_port_v2.port_details : id => port 
                    if can(regex("^compute:", port.device_owner)) }
  
  # Group ports by instance ID
  ports_by_instance_id = {}
  ports_by_instance = { for id, port in local.instance_ports : 
                        port.device_id => port... if port.device_id != "" }
  
  # Get instance details for each unique instance ID
  instances = { for instance_id, ports in local.ports_by_instance : instance_id => {
    id = instance_id
    name = try(ports[0].name, "unknown")
    status = try(ports[0].status, "unknown")
    networks = { for port in ports : port.network_id => {
      fixed_ips = port.fixed_ip
      mac_address = port.mac_address
    }}
  }}
}

# For each instance ID, get more details if available
data "openstack_compute_instance_v2" "instance_details" {
  for_each = { for id, instance in local.instances : id => instance if id != "" }
  id       = each.key
}

# Combine all instance information
locals {
  enriched_instances = { for id, instance in local.instances : id => merge(instance, {
    flavor = try(data.openstack_compute_instance_v2.instance_details[id].flavor_name, "unknown")
    image = try(data.openstack_compute_instance_v2.instance_details[id].image_name, "unknown")
    power_state = try(data.openstack_compute_instance_v2.instance_details[id].power_state, "unknown")
    created = try(data.openstack_compute_instance_v2.instance_details[id].created, "unknown")
  }) if id != "" }
}

# Output all instances with their details
output "all_instances" {
  value = local.enriched_instances
}

output "current_project" {
  value = data.openstack_identity_auth_scope_v3.scope.project_name
}
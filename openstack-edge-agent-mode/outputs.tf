# Output definitions

# Output the created Ubuntu VM
output "ubuntu_vm" {
  value = {
    name   = openstack_compute_instance_v2.ubuntu_vm.name
    id     = openstack_compute_instance_v2.ubuntu_vm.id
    ip     = openstack_compute_instance_v2.ubuntu_vm.access_ip_v4
    flavor = openstack_compute_instance_v2.ubuntu_vm.flavor_name
    status = openstack_compute_instance_v2.ubuntu_vm.power_state
  }
}

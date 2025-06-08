# Output definitions

# Output the created VMs
output "created_vms" {
  value = {
    for i, vm in openstack_compute_instance_v2.edge_vm : vm.name => {
      id = vm.id
      ip = vm.access_ip_v4
      flavor = vm.flavor_name
      status = vm.power_state
    }
  }
}

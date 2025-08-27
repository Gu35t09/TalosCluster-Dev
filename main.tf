resource "proxmox_virtual_environment_download_file" "download-talos-iso" {
  count = var.cp_total_count
  content_type = "iso"
  datastore_id = "local"
  file_name = "metal-amd64-secureboot.iso"
  node_name = var.cp_proxmox_nodes[count.index]
  url = var.iso_download_url
}

resource "proxmox_virtual_environment_vm" "cp-vm" {
  depends_on = [
    proxmox_virtual_environment_download_file.download-talos-iso # wait for the ISO download to be finished
  ]
  count = var.cp_total_count # repeat this task for cp_total_count times
  vm_id = sum([var.starting_cp_vm_id, count.index])
  name = "k8s-talos-dev-cp0${count.index+1}"
  node_name = var.cp_proxmox_nodes[count.index]
  bios = "ovmf"
  on_boot = true
  operating_system {
    type = "l26" # Linux kernel type
  }
  tpm_state {
    version = "v2.0"
    datastore_id = var.cp_vm_datastore
  }
  efi_disk {
    datastore_id = var.cp_vm_datastore
  }
  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
  }
  cpu {
    cores = var.cp_core
    type = "host"
  }
  memory {
    dedicated = var.cp_ram
  }
  cdrom {
    enabled = true
    file_id = "local:iso/metal-amd64-secureboot.iso"
  }
  disk { 
    datastore_id = var.cp_vm_datastore
    interface = "virtio0"
    size = var.cp_disk_size
    ssd = true
    file_format = "raw"
    iothread = true
    backup = false
  }
  network_device {
    bridge = var.cp_network_bridge
    mac_address = var.cp_mac_address[count.index]
  }
  vga {
    type = "std"
  }
}


resource "proxmox_virtual_environment_vm" "worker-vm" {
  depends_on = [
    proxmox_virtual_environment_download_file.download-talos-iso
  ]
  count = var.worker_total_count
  vm_id = sum([var.starting_worker_vm_id, count.index]) # For example the first worker if we start with VMID 201 and have 3 control plane would have the VMID 204 (201+0+3=204)
  name = "k8s-talos-dev-wrk0${count.index+1}"
  node_name = var.worker_proxmox_nodes[count.index]
  bios = "ovmf"
  on_boot = true
  operating_system {
    type = "l26" # Linux kernel type
  }
  tpm_state {
    version = "v2.0"
    datastore_id = var.worker_vm_datastore
  }
  efi_disk {
    datastore_id = var.worker_vm_datastore
  }
  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
  }
  cpu {
    cores = var.worker_core
    type = "host"
  }
  memory {
    dedicated = var.worker_ram
  }
  cdrom {
    enabled = true
    file_id = "local:iso/metal-amd64-secureboot.iso"
  }
  disk {
    datastore_id = var.worker_vm_datastore
    interface = "virtio0"
    size = var.worker_disk_size
    ssd = true
    file_format = "raw"
    iothread = true
    backup = false
  }
  disk {
    datastore_id = var.worker_vm_datastore
    interface = "virtio1"
    size = var.worker_disk2_size
    ssd = true
    file_format = "raw"
    iothread = true
    backup = false
  }
  network_device {
    bridge = var.worker_network_bridge
    mac_address = var.worker_mac_address[count.index]
  }
  vga {
    type = "std"
  }
}

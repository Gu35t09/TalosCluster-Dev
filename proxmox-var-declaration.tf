# Generic proxmox variables
variable "proxmox_api_token_id" {
  description = "The ID of the API token used for authentication with the Proxmox API."
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "The secret value of the token used for authentication with the Proxmox API."
  type        = string
}

variable "proxmox_api_url" {
  description = "The URL for the Proxmox API."
  type        = string
}


# Control Plane specific variables
variable "cp_total_count" {
  description = "Total number of Control Plane to deploy"
  type = number
  default = 3
}

variable "starting_cp_vm_id" {
  description = "The VM ID of the first Control Plane VM"
  type = number
}

variable "cp_proxmox_nodes" {
  description = "The Proxmox node where to deploy the Control Plane"
  type = list(string)
  default = ["pve-01", "pve-02", "pve-03"]
}

variable "cp_ram" {
  description = "Memory assigned to the Control Plane VM"
  type = number
  default = 4096
}

variable "cp_core" {
  description = "Number of core to assign to the Control Plane VM"
  type = number
  default = 2
}

variable "cp_vm_datastore" {
  description = "The Proxmox datastore to use for Control Plane VM"
  type = string
  default = "local-zfs"
}

variable "cp_disk_size" {
  description = "Disk size of Control Plane VM"
  type = number
  default = 30
}

variable "cp_mac_address" {
  description = "Mac address to assign to Control Plan VM"
  type = list(string)
}

variable "cp_network_bridge" {
  description = "The Proxmox bridge to assign to Control Plane VM"
  type = string
  default = "vmbr0"
}


# Worker specific variables
variable "worker_total_count" {
  description = "Total number of Control Plane to deploy"
  type = number
  default = 3
}

variable "starting_worker_vm_id" {
  description = "The VM ID of the first Control Plane VM"
  type = number
}

variable "worker_proxmox_nodes" {
  description = "The Proxmox node where to deploy the Control Plane"
  type = list(string)
  default = ["pve-01", "pve-02", "pve-03"]
}

variable "worker_ram" {
  description = "Memory assigned to the Control Plane VM"
  type = number
  default = 4096
}

variable "worker_core" {
  description = "Number of core to assign to the Control Plane VM"
  type = number
  default = 2
}

variable "worker_vm_datastore" {
  description = "The Proxmox datastore to use for Control Plane VM"
  type = string
  default = "local-zfs"
}

variable "worker_disk_size" {
  description = "Disk size of Control Plane VM"
  type = number
  default = 15
}

variable "worker_disk2_size" {
  description = "Disk size of Control Plane VM"
  type = number
  default = 50
}

variable "worker_network_bridge" {
  description = "The Proxmox bridge to assign to Control Plane VM"
  type = string
  default = "vmbr0"
}

variable "worker_mac_address" {
  description = "Mac address to assign to Control Plan VM"
  type = list(string)
}

variable "iso_download_url" {
  type = string
}

variable "installation_image" {
  description = "Installation image used by talos" # https://www.talos.dev/v1.9/learn-more/image-factory/
  type = string
}

variable "control_planes_ip" {
  description = "The IP of the control planes nodes"
  type        = list(string)
}

variable "worker_ip" {
  description = "The IP of the worker nodes"
  type        = list(string)
}

variable "cluster_endpoint" {
  description = "The Kubernetes cluster endpoint"
  type = string
}

variable "cluster_name" {
  description = "Cluster name"
  type = string
  default = "talos-proxmox-cluster"
}


variable "vip" {
  description = "Talos VIP for redundant Kubernetes endpoint" # https://www.talos.dev/v1.9/talos-guides/network/vip/
  type = string
}
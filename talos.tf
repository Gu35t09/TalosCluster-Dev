resource "talos_machine_secrets" "this" {} # Generate machine secrets for Talos cluster.

data "talos_client_configuration" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  cluster_name = var.cluster_name
  nodes = var.control_planes_ip
  endpoints = var.control_planes_ip
}

data "talos_machine_configuration" "cp" {
  cluster_name = var.cluster_name
  machine_type = "controlplane"
  cluster_endpoint = var.cluster_endpoint
  machine_secrets = talos_machine_secrets.this.machine_secrets
}

resource "talos_machine_configuration_apply" "control-planes" {
  count = var.cp_total_count
  client_configuration = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.cp.machine_configuration
  node = var.control_planes_ip[count.index]
  config_patches = [
    templatefile("${path.module}/talos-config/control-plane.yaml.tpl", {
      vip = var.vip
      installation_disk = "/dev/vda"
      installation_image = var.installation_image
    }),
  ]
}

data "talos_machine_configuration" "worker" {
  machine_type = "worker"
  machine_secrets = talos_machine_secrets.this.machine_secrets
  cluster_name = var.cluster_name
  cluster_endpoint = var.cluster_endpoint
}

resource "talos_machine_configuration_apply" "worker" {
  count = var.worker_total_count
  client_configuration = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node = var.worker_ip[count.index]
  config_patches = [
    templatefile("${path.module}/talos-config/worker.yaml.tpl", {
      installation_disk = "/dev/vda"
      additional_disk_1 = "/dev/vdb" # Storage disk (see worker_disk2_size in terraform.tfvars)
      installation_image = var.installation_image
    }),
  ]
}

resource "talos_machine_bootstrap" "control-planes" {
  depends_on = [
    talos_machine_configuration_apply.control-planes
  ]
  node = var.control_planes_ip[0]
  client_configuration = talos_machine_secrets.this.client_configuration
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [
    talos_machine_bootstrap.control-planes
  ]
  client_configuration = talos_machine_secrets.this.client_configuration
  node = var.control_planes_ip[0]
}
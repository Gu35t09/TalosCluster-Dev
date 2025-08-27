# VM creation - Control Plane
cp_total_count = 1 # Number of requied Control Plane VM/nodes
starting_cp_vm_id = 231
cp_proxmox_nodes = [ "pve" ] # Proxmox nodes where to provision Control Plane. Example ["pve", "pve02", "pve03"]
cp_ram = 4096 # Control Plane VM ram (in MB)
cp_core = 4 # Control Plane VM number of core
cp_vm_datastore = "local-zfs"
cp_disk_size = 15 # Control Plane VM disk size 
cp_mac_address = ["bc:24:11:cc:31:52"] # Control Plane VM mac address (for DHCP reservation)
cp_network_bridge = "vmbr0"

# VM creation - worker
worker_total_count = 1 # Number of requied Worker VM/nodes
starting_worker_vm_id = 234
worker_proxmox_nodes = [ "pve" ] # Same as above for Control Plane
worker_ram = 8096 # Worker VM ram (in MB)
worker_core = 4 # Worker VM number of core
worker_vm_datastore = "local-zfs"
worker_disk_size = 15 # Worker VM disk size 
worker_disk2_size = 50
worker_mac_address = ["bc:24:11:99:e2:a7"] # Worker VM mac address (for DHCP reservation)
worker_network_bridge = "vmbr0"


# Talos configuration
iso_download_url = "https://factory.talos.dev/image/88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b/v1.10.5/metal-amd64-secureboot.iso"
installation_image = "factory.talos.dev/metal-installer-secureboot/88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b:v1.10.5"
cluster_name = "talos-proxmox-dev-cluster"
control_planes_ip = ["192.168.100.231"]
worker_ip = ["192.168.100.234"]
vip = "192.168.100.230" # https://www.talos.dev/v1.9/talos-guides/network/vip/
cluster_endpoint = "https://192.168.100.230:6443" # This needes to be the same as the Talos "vip" for redundancy

machine:
  network:
    interfaces:
      - deviceSelector:
          physical: true # should select any hardware network device, if you have just one, it will be selected
        dhcp: true
        vip:
          ip: ${vip}
  install:
    disk: ${installation_disk}
    image: ${installation_image}
  systemDiskEncryption:
    ephemeral:
      provider: luks2
      keys:
        - slot: 0
          tpm: {}
    state:
      provider: luks2
      keys:
        - slot: 0
          tpm: {}

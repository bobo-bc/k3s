# Build your OS image and turn into a template

download an img file. from here. with wget
`https://cloud-images.ubuntu.com/noble/current/`

Let’s say your VM ID will be 9000 (common for templates). Replace tank with your real storage name.
# Move the uploaded image from ISO storage to the right place
`qm create 9000 --name ubuntu-2404 --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0`

# Import the disk image

`qm importdisk 9000 noble-server-cloudimg-amd64.img local-lvm`

# Attach the disk

`qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0`

# Add cloud-init drive

`qm set 9000 --ide2 local-lvm:cloudinit`

# Boot order and serial console

`qm set 9000 --boot c --bootdisk scsi0`
`qm set 9000 --serial0 socket --vga serial0`
 
You’ll have a working VM template using the cloud image.
Convert it into a Proxmox template:
 
`qm template 9000`

Then you can clone it and apply your cloud-init 
 
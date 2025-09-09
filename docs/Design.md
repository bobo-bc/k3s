# My homelab 
## Domain 
smeyer.ca with DNS registered and managed via Cloudflare for cloudflared tunnel, DNS challenge for traefik-letsencrypt
## Hardware
Unifi Gateway Ultra with jacknife wifi node to have full visibility and oversite of my network

Minisforum MS01 hosting proxmox -PVE.smeyer.ca
> * 1 x 2 Terabyte NVMe for OS, Local and Local-lvm storage. 
> * 2 x 2 Terabytes NVMe ZFS mirror used for NFS storage (media and PVCs)

2012 Mac mini repurposed as proxmox host -PVE2.smeyer.ca
> * 1 x 1 Terabyte Sata SSD for OS, Local and Local-lvm storage
> * 2 x 2 Terabyte USB Sata SSD ZFS mirror used for backup storage

Raspberry Pi 4 with 4 gig RAM
> * 1 terabyte USB sata SSD for Raspbian OS pihost.smeyer.ca

## PVE.smeyer.ca
Proxmox will be NFS host managing ZFS directory /tank.
Exports will include 
> /tank/media/(tv, movies, music, books, files).   -static pvc provisioned
> /tank/k8s-nfs/.                                  - dynamic pvc provisioning destination

## PVE2.smeyer.ca
Proxmox will primarily host proxmox backup server as vm and available to host docker vm's such as CasaOS for testing possible apps. 

## pihost.smeyer.ca
Pihole backup, docker host outside of lab to host backup of public website. * might make this a k3s standalone. 

## Github
It is critically important to keep your work. GitHub is designed for homelab projects such as this. Besides this wiki, it is effective for code deployment which I used extensively with portainer in docker swarm and ArgoCD for kubernetes. 




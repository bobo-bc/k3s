# the Cluster
I experimented with 3 master nodes using etcd but found it very chatty and overkill. in a homelab just make snapshots and backups and save the resources. 

## The Build

create from template a vm server with 

### Master node
* 6 gig ram
* 50 gig HD
* 4 VCPU 

### Worker nodes (I made 2)
* 8 gig ram
* 50 gig HD
* 4 VCPU

## Install the the master

you need to ssh into the server and run 

`curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -`

when complete get the token

`sudo cat /var/lib/rancher/k3s/server/node-token`

## Join the workers
on each worker ssh into them

`curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_IP>:6443 K3S_TOKEN=<TOKEN> sh -`

Install NFS
while logged into the nodes install 

`sudo apt update && sudo apt install -y nfs-common`



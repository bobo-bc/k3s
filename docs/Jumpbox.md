# Build your jumpbox

### clone ubuntu server vm with 
2vcpu
2 gig ram
32 gig HD

### install kubectl

`sudo snap install kubectl --classic`

### install Helm

`curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash`

### Create SSH key

`mkdir -p ~/.kube`
`create ssh key`
`ssh-keygen -t ed25519`

Copy this to ssh in cloudinit template. and reboot
 
### manage newly create k3s controller
 
copy config k3s config to local machine

`scp bobo@10.0.0.15:/etc/rancher/k3s/k3s.yaml ~/.kube/config`

then 

`sed -i 's/127.0.0.1/10.0.0.15/' ~/.kube/config`
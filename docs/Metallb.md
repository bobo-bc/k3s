# Metallb

You need this to assign IP addresses. I will use Traefik for most apps but will need a small pool for Treafik itself, Argocd, and a few apps that I do not want to be part of traefik. 

 
## Add the MetalLB repo
 
`helm repo add metallb https://metallb.github.io/metallb`
`helm repo update`
 
 
 
## Install MetalLB into its own namespace
 
`kubectl create namespace metallb-system`
`helm install metallb metallb/metallb -n metallb-system`

This deploys both the controller and the speaker.
 
 
 
## Wait until pods are ready
 
`kubectl get pods -n metallb-system`

You should see controller and speaker pods running.
 
 
 
## Define your IPAddressPool

run this as a bash

`cat <<EOF | kubectl apply -f -`
`apiVersion: metallb.io/v1beta1`
`kind: IPAddressPool`
`metadata:`
 `name: default-pool`
 `namespace: metallb-system`
`spec:`
 `addresses:`
 `- 10.0.0.20-10.0.0.29`
`EOF`

### then attach a L2 advertisement

`cat <<EOF | kubectl apply -f -`
`apiVersion: metallb.io/v1beta1`
`kind: L2Advertisement`
`metadata:`
  `name: default-advertisement`
  `namespace: metallb-system`
`spec:`
  `ipAddressPools:`
  `- default-pool`
`EOF`
 
### Verify
 
`kubectl get ipaddresspool -n metallb-system`
`kubectl get l2advertisements -n metallb-system`

Now, any LoadBalancer service you create will pull an IP from 10.0.0.20–29.
 
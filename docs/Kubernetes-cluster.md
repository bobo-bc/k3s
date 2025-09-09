# Kubernetes

Kubernetes is a culmination of learned skills and effort to build an enterprise grade hosting environment. If you are starting your journey take advise and learn docker and yaml. build a swarm. provision with portainer before you even try Kubernetes. 

I could not have gotten here without Chat-GPT but....chat has taken me down rabbit holes and provided false information. so do not use it blindly which one is ought to do. Learn prompts and be sure to frame your request often. it is easy to get into a conversation mode instead of using the engine the way it was built.

## OS
I have tried to build K3s on different OSs thinking a linux host is just a host.  I have learned from much trial and error that Ubuntu Server LTS has embedded helper scripts and Cloud-init which makes cloning and configuration easy and efficient. 

## K3s
K3s is a single binary which makes it light and allows experiments on small edge devices. I find in the homelab one is always looking to save resources and k3s is a good way to do that. I tend to install disabling traefik so I can install a full blown traefik afterward. 

## Bootstrap
This is a techie term for timing the base platform together. My bias is to get a functional platform working as quickly as possible and install Argocd. Then use argo and git to deploy apps in a structured way. So my bootstrap is to

> Install K3s and disable traefik
> install metallb with a small IP address pool like 10.0.0.20-10.0.0.29
> Install ArgoCD with assigned metallb IP 10.0.0.20
> > Assign your GitHub main in argocd to pull yaml and deploy to your k3s instance. 

## Dependencies
* Build a jumpbox to kubectl to manage the cluster. It can get messy and you do not want to clutter your laptop or desktop. 
* create a pihole lxc as traefik requires proper names to resolve and present pages. 
* in your cloudinit template define preferred username, password, and copy ssh keys from both your laptop and jumpbox.  Ubuntu requires it. 

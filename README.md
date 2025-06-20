# k3s Homelab

This repo documents my self-hosted homelab running a lightweight Kubernetes cluster using **K3s** across 3 Ubuntu Server nodes.

---

## Key Components

- **MetalLB**  
  Assigns static IPs from a predefined pool to each deployed app.

- **Longhorn**  
  Handles persistent storage for application config files, stored locally on each node.

- **NFS**  
  Used for shared media storage — for example, Sonarr, Radarr, and Jellyfin.

- **YAML-First Approach**  
  I manage apps using raw YAML manifests (instead of Helm) for better control, transparency, and easier troubleshooting.

- **ChatGPT**  
  A major help in generating and refining these YAML manifests and resolving Kubernetes issues quickly.

- **Jumpbox**  
  I use a Linux VM as a jumpbox to interact with the cluster using `kubectl`.

---

## Structure

Each app is typically deployed with two main YAML files:

1. **PersistentVolumeClaim (PVC)**  
   Defines storage for config or application data.

2. **App Deployment YAML**  
   Includes:
   - The container image and environment variables
   - Volume mounts (including NFS if applicable)
   - A Kubernetes `Service` (usually `LoadBalancer` with a static MetalLB IP)
   - Security context or `initContainers` if needed (e.g., to fix permissions)

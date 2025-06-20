**k3s Homelab**

This repo documents my self-hosted homelab running a lightweight Kubernetes cluster using K3s across 3 Ubuntu Server nodes.

Key Components
	•	MetalLB is used to assign static IPs from a predefined pool to each deployed app.
	•	Longhorn handles persistent storage for application config files (stored locally on each node).
	•	NFS is used for shared media storage (e.g., for apps like Sonarr, Radarr, Jellyfin).
	•	YAML-first approach: I manage apps using raw YAML manifests instead of Helm for better control, transparency, and easier troubleshooting.
	•	ChatGPT has been a major help in generating and refining these YAML manifests and resolving Kubernetes issues quickly.
	•	I use a Linux VM (jumpbox) as my main point of interaction with the cluster, managing everything via kubectl.

Structure

Each app is generally deployed using two main YAML files:
	1.	PersistentVolumeClaim (PVC): Defines storage for config or data.
	2.	App Deployment: Contains:
	•	The container spec and environment variables
	•	Volume mounts (including NFS if needed)
	•	Service definition (LoadBalancer with a MetalLB IP)
	•	Security context or init containers if required

⸻

Let me know if you want help organizing the repo into folders or adding examples with links.

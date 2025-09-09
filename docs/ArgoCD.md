# ArgoCD
This is a super friendly way to manage code and ensure managed deployment in a nice Gui interface. I find it provides enough information to troubleshoot without the need for another tool. <so far>


## Install ArgoCD into its own namespace
```bash
kubectl create namespace argocd
```
```bash
kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
That will spin up all the ArgoCD components.
 
 
 
## Patch the ArgoCD server Service to use LoadBalancer
 
 
By default, ArgoCD installs the argocd-server service as ClusterIP. You need to change it to LoadBalancer and assign the MetalLB IP.
```bash
kubectl patch svc argocd-server -n argocd \
  -p '{"spec": {"type": "LoadBalancer", "loadBalancerIP": "10.0.0.20"}}'
```
 
 
 
## Verify that MetalLB assigned the IP
```bash 
kubectl get svc -n argocd
```
You should see:
argocd-server   LoadBalancer   10.43.XXX.XXX   10.0.0.20   80:XXXXX/TCP,443:XXXXX/TCP   ...

## Get the ArgoCD admin password

ArgoCD auto-generates a password for the admin user:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d; echo
``` 
 
 
## Access ArgoCD
 
 
Open: https://10.0.0.20
Username: admin
Password: (from step 4)
 
 

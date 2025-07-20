I found it easiest and most stable to install argocd from helm. do it as follows  
1. kubectl create namespace argocd
2. create argocd-values file
3. add repo:
4.   
     helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd \
  --namespace argocd \
  --values argocd-values.yaml   


  get argocd admin password:  

    

  
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo


  


  

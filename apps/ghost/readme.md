I have done alot of experimenting with ghost blog in my k3s environment. I like the responsiveness of mysql8 on the back end but always ran into an issue with authorization encryption which would lock me out of the admin panel. SO I decidedto do a plane jane bitnami/ghost helm. My values file accomodates PVC for the data and metallb fixed IP so Ican use cloudlfare tunnel. 
the steps are
1. kubectl create namespace ghost
2. create a ghost-values.yaml file
3.get helm chart:

  helm repo add bitnami https://charts.bitnami.com/bitnami  
  helm repo update

4. deploy via helm chart: helm install ghost bitnami/ghost -n ghost -f ghost-values.yaml

5. follow the command line instructions to get the default username and password to login for the first time

echo Email:    user@example.com  
  echo Password: $(kubectl get secret --namespace ghost ghost -o jsonpath="{.data.ghost-password}" | base64 -d)

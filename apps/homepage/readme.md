getHomepage is awesome, I love the customizations. Mananging the various config files in kubernetes is very different than in docker so it took a minute to figure out the best thing to do is keep it simple. 


Do not bother with a persistent volume claim. stay with a config map. 
Create a config.yaml file to set up your dashboard in a flat file. 

to deploy via helm,  
helm repo add jameswynn https://jameswynn.github.io/helm-charts  
helm repo update

then  
helm upgrade --install homepage jameswynn/homepage \   
  -n homepage -f homepage-values.yaml
   
when done making changes,   
kubectl apply -f config.yaml




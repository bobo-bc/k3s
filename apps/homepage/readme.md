getHomepage is awesome, I love the customizations. Mananging the various config files in kubernetes is very different than in docker so it took a minute to figure out the best thing to do is keep it simple. 


Do not bother with a persistent volume claim. stay with a config map. 
Create a config.yaml file to set up your dashboard in a flat file. 

to deploy create a homepage.yaml file with all the requirements, 
 To make config changes to design your dashboard build a config.yaml file (watch the spacing)
   
when done making changes,   
kubectl apply -f config.yaml




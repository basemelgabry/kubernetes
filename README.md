Hi Bro,
# ## Localhost k8s-and-helm
# kubernetes apps CLI heml Terraform

# GIT Branch : 
> git clone -b  localhost-k8s-and-helm https://github.com/basemelgabry/kubernetes.git
> cd kubernetes
# Create NameSpace:   > kubectl create ns demo1    > kubectl create ns demo2

#1 - To Deployment Nginx app in localhost

# insttaltion 
    
> helm install demo1 ./demo1/ -n demo1


# browsing  
    
> http://localhost   
    
# Upgrade 
    
> helm upgrade --install demo1 ./demo1/ -n demo1
    
 # Over right
    
> Helm upgrade --install --set ingress.name=ingresstest demo1 .\demo1\ -n demo1
    
# uninstall app
    
> helm uninstall demo1 ./dem1o/ -n demo1

======================================================

#2 - To Deployment Game 2048 app in localhost

# insttaltion
   
> helm install demo2 ./demo2/ -n demo2    # browsing      http://localhost:9010/
   
# Upgrade
   
> helm upgrade --install demo2./demo2/ -n demo2
   
# Over right
   
> Helm upgrade --install --set ingress.name=ingresstest demo2 .\demo2\ -n demo2
    
# uninstall app
   
> helm uninstall demo2 ./demo2/ -ndemo2


#3 - To Deployment  Nginx & Game 2048 apps in localhost ( one directory | different values files)
Notes : delete old NameSpace and create new one if you will use the same names

> helm install -f .\demo-mex\values-demo1.yaml demo1 .\demo1\ -n demo1    
     http://localhost

> helm install -f .\demo-mex\values-demo2.yaml demo2 .\demo2\ -n demo2
    http://localhost:9010/



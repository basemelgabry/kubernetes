# ## LocalHost k8s-and-helm
kubernetes
kubernetes apps CLI &amp; Terraform

1 - To Deplayment nginx app in localhost
    # insttaltion 
    > helm install demo1 ./demo/ -n demo1
    # Upgrade 
    > helm upgrade --install demo1 ./demo/ -n demo1
    # uninstall app
    > helm uninstall demo1 ./demo/ -n demo1

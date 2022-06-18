# git clone -b game-2048-nginx-full-github https://github.com/basemelgabry/kubernetes.git
# cd kubernetes
# sh create.sh

##################TEST#####
 # aws configure
 # aws sts get-caller-identity
 # aws eks --region "us-east-1" update-kubeconfig --name "BasClusterB"
#########################
# Deleting an Amazon EKS cluster https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html
kubectl get svc --all-namespaces
kubectl delete svc <service-name>
eksctl delete cluster --name <prod>


## Delete EKS cluster
eksctl delete cluster --name BasClusterB --region us-east-1 --wait
### Delete Status
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks?filteringStatus=active&filteringText=&viewNested=true&hideStacks=false
  
#########################
  
# Deregistering a cluster
  eksctl deregister cluster --name
To clean up the resources on your Kubernetes cluster.

Delete the Amazon EKS Connector YAML file from your Kubernetes cluster.

kubectl delete -f eks-connector.yaml


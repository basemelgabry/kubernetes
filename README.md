# git clone -b game-2048-nginx-full-github https://github.com/basemelgabry/kubernetes.git
# cd kubernetes
# sh creat.sh

#######################
# Deleting an Amazon EKS cluster https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html
kubectl get svc --all-namespaces
kubectl delete svc <service-name>
eksctl delete cluster --name <prod>


## Delete EKS cluster
eksctl delete cluster --name eksingressdemo --region us-east-1 --wait
### Delete Status
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks?filteringStatus=active&filteringText=&viewNested=true&hideStacks=false

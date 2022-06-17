# git clone -b game-2048-nginx-full-github https://github.com/basemelgabry/kubernetes.git
# cd kubernetes
# sh creat.sh

#######################

## Delete EKS cluster
eksctl delete cluster --name eksingressdemo --region us-east-1 --wait
### Delete Status
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks?filteringStatus=active&filteringText=&viewNested=true&hideStacks=false

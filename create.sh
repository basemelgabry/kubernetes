#!/bin/bash

## Downlod Files from my github
# git clone -b game-2048-nginx-full-github https://github.com/basemelgabry/kubernetes.git
# cd kubernetes
# sh creat.sh



#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Create EKS cluster ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Create EKS cluster
eksctl create cluster --name BasClusterC --node-type t2.large --nodes 3 --nodes-min 3 --nodes-max 5 --region us-east-1 --zones=us-east-1a,us-east-1b,us-east-1d
sleep 30
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Get EKS Cluster service ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Get EKS Cluster service
eksctl get cluster --name BasClusterC --region us-east-1

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to  Create IAM OIDC provider ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#


## Create IAM OIDC provider
eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster BasClusterC --approve

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Create an IAM policy called ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Create an IAM policy called
#curl -k   "https://raw.githubusercontent.com/basemelgabry/kubernetes/game-2048/iam_policy.json" -o iam_policy2.json
sleep 10
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Create a IAM role and ServiceAccount ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Create a IAM role and ServiceAccount
eksctl create iamserviceaccount --cluster BasClusterC --namespace kube-system --name aws-load-balancer-controller --attach-policy-arn arn:aws:iam::411218437052:policy/AWSLoadBalancerControllerIAMPolicy --override-existing-serviceaccounts --approve

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Install the TargetGroupBinding CRDs ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Install the TargetGroupBinding CRDs
kubectl apply -k github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to get crd?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
kubectl get crd

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Deploy the Helm chart ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Deploy the Helm chart
helm repo add eks https://aws.github.io/eks-charts

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Configure AWS ALB  ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Configure AWS ALB (Apllication Load Balancer) to sit infront of Ingress
#helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=BasClusterC --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set image.tag="v2.2.0"
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=BasClusterC --set serviceAccount.create=false --set region=us-east-1 --set serviceAccount.name=aws-load-balancer-controller

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to status deployment ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

kubectl -n kube-system rollout status deployment aws-load-balancer-controller

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Deploy Sample Application ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Deploy Sample Application
kubectl apply -f  deployment-game-2048.yaml
kubectl apply -f  service-game-2048.yaml
kubectl apply -f  ingress-game-2048.yaml

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Verify Ingress ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Verify Ingress
kubectl get ingress/ingress-2048 -n game-2048

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to  Get Ingress URL ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Get Ingress URL
kubectl get ingress/ingress-2048 -n game-2048 -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' > game-2048.txt
cat game-2048.txt

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Get EKS Pod data ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Get EKS Pod data.
kubectl get pods --all-namespaces


#################### Nignx #####################
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Deploy Sample Application ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Deploy Sample Application

kubectl apply -f  deployment-nignx.yaml
kubectl apply -f  service-nignx.yaml
kubectl apply -f  ingress-nignx.yaml

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Verify Ingress ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Verify Ingress
kubectl get ingress/nginx-ingress -n nginx-ns

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
echo " Ready to Get Ingress URL ?"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) make install; break;;

        No ) exit;;

    esac

done
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Get Ingress URL
kubectl get ingress/nginx-ingress -n nginx-ns -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' > nginx.txt
cat nginx.txt

#!/bin/bash

## Downlod Files from my github
# git clone -b game-2048 git@github.com:basemelgabry/kubernetes.git



#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Create EKS cluster ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Create EKS cluster
eksctl create cluster --name BasClusterB --node-type t2.large --nodes 3 --nodes-min 3 --nodes-max 5 --region us-east-1 --zones=us-east-1a,us-east-1b,us-east-1d
sleep 30
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Get EKS Cluster service ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Get EKS Cluster service
eksctl get cluster --name BasClusterB --region us-east-1

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to  Create IAM OIDC provider ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#


## Create IAM OIDC provider
eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster BasClusterB --approve

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Create an IAM policy called ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Create an IAM policy called
#curl -k   "https://raw.githubusercontent.com/basemelgabry/kubernetes/game-2048/iam_policy.json" -o iam_policy2.json
sleep 10
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Create a IAM role and ServiceAccount ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Create a IAM role and ServiceAccount
eksctl create iamserviceaccount --cluster BasClusterB --namespace kube-system --name aws-load-balancer-controller --attach-policy-arn arn:aws:iam::411218437052:policy/AWSLoadBalancerControllerIAMPolicy --override-existing-serviceaccounts --approve

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Install the TargetGroupBinding CRDs ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Install the TargetGroupBinding CRDs
kubectl apply -k github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to get crd? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
kubectl get crd

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Deploy the Helm chart ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

## Deploy the Helm chart
helm repo add eks https://aws.github.io/eks-charts

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Configure AWS ALB  ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Configure AWS ALB (Apllication Load Balancer) to sit infront of Ingress
#helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=BasClusterB --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set image.tag="v2.2.0"
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=BasClusterB --set serviceAccount.create=false --set region=us-east-1 --set serviceAccount.name=aws-load-balancer-controller

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to status deployment ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#

kubectl -n kube-system rollout status deployment aws-load-balancer-controller

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Deploy Sample Application ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Deploy Sample Application
kubectl apply -f  deployment-game-2048.yaml
kubectl apply -f  service-game-2048.yaml
kubectl apply -f  ingress-game-2048.yaml

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Verify Ingress ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Verify Ingress
kubectl get ingress/ingress-2048 -n game-2048

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to  Get Ingress URL ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Get Ingress URL
kubectl get ingress/ingress-2048 -n game-2048 -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' > game-2048.txt
cat game-2048.txt

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Get EKS Pod data ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Get EKS Pod data.
kubectl get pods --all-namespaces


#################### Nignx #####################
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Deploy Sample Application ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Deploy Sample Application

kubectl apply -f  deployment-nginx.yaml
kubectl apply -f  service-nginx.yaml
kubectl apply -f  ingress-nginx.yaml

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Verify Ingress ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Verify Ingress
kubectl get ingress/nginx-ingress -n nginx-ns

#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
read -p " Ready to Get Ingress URL ? (yes=1/no=2) " yn



    case $yn in

        1 ) echo ok, we will proceed;;

        2 ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 3;;

    esac
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
#*#*#*#*#*#*#========================#*#*#*#*#*#*#
## Get Ingress URL
kubectl get ingress/nginx-ingress -n nginx-ns -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' > nginx.txt
cat nginx.txt

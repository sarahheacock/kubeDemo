
.PHONY: build
build:
	docker build -t sarahheacock/hello-world-nginx:v1 .
	docker push sarahheacock/hello-world-nginx

.PHONY: run-docker
run-docker:
	docker run -p 8080:80 sarahheacock/hello-world-nginx:v1

.PHONY: run-kube
run-kube:
	kubectl create -f ./demo.yaml

.PHONY: run-terraform
run-terraform:
	terraform plan -var server_port="8080"
	terraform apply

.PHONY: run-kops
run-kops:
	aws route53 create-hosted-zone --name dev.example.com --caller-reference 1
	# export NAME=kops-cluster-a.connect.cd
	# aws s3api create-bucket --bucket $NAME-state-storage --acl private
	# export KOPS_STATE_STORE=s3://$NAME-state-storage
	# export ZONES="us-east-1a,us-east-1b,us-east-1c"
	# export REGION=$(echo $ZONES | awk -F, '{ print $1 }' | sed 's/-/_/g' | sed 's/.$//')
	# export IMAGE=$(curl -s https://coreos.com/dist/aws/aws-stable.json|sed 's/-/_/g'|jq '.'$REGION'.hvm'|sed 's/_/-/g' | sed 's/\"//g')
	# ssh-keygen -t rsa -f $NAME.key -N ''
	# export PUBKEY="$NAME.key.pub"
	# export KUBEVER="1.7.2" # ARCH=linux
	# kops create cluster --topology private \
	# --zones $ZONES \
	# --master-zones $ZONES \
	# --networking flannel \
	# --node-count 2 \
	# --master-size t2.small \
	# --node-size t2.medium \
	# --image $IMAGE \
	# --kubernetes-version $KUBEVER \
	# --api-loadbalancer-type public \
	# --admin-access 0.0.0.0/0 \
	# --authorization RBAC \
	# --ssh-public-key $PUBKEY \
	# --cloud aws \
	# --bastion \
	# --name ${NAME} \
	# --yes

.PHONY: delete
delete:
	kubectl delete service my-service
	kubectl delete deployment my-deployment

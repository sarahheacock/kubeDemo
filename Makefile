.PHONY: run-docker
run-docker:
	docker run -p 8080:80 sarahheacock/hello-world-nginx:v1

.PHONY: run-terraform
run-terraform:
	terraform plan -var server_port="8080"
	terraform apply

 #########################################################################
.PHONY: run-kops
run-kops:
	# ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
	aws s3api create-bucket --bucket sarah-k8s-store --region us-east-1

	export NAME=sarah-workshop.k8s.local
	export KOPS_STATE_STORE=s3://sarah-k8s-store

	kops create cluster ${NAME} --zones us-east-1a
	kops update cluster ${NAME} --yes


.PHONY: build
build:
	docker build -t sarahheacock/hello-world-nginx:v1 .
	docker push sarahheacock/hello-world-nginx
	kubectl create -f ./demo.yaml
	# kubectl desribe service my-service --> get external-ip of service

.PHONY: edit
edit:
	# change image to v2 in demo.yaml
	docker build -t sarahheacock/hello-world-nginx:v2 .
	docker push sarahheacock/hello-world-nginx
	kubectl apply -f ./demo.yaml
##################################################################################

.PHONY: delete-kops
delete-kops:
	kops delete cluster --name ${NAME} --yes
	aws s3api delete-bucket --bucket sarah-k8s-store --region us-east-1

.PHONY: delete
delete:
	kubectl delete service my-service
	kubectl delete deployment my-deployment

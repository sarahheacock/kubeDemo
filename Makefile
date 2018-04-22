
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

.PHONY: delete
delete:
	kubectl delete service my-service
	kubectl delete deployment my-deployment

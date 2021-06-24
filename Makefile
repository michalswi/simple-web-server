GOLANG_VERSION := 1.15.6
ALPINE_VERSION := 3.13

GIT_REPO := github.com/michalswi/simple-web-server
DOCKER_REPO := michalsw
APPNAME := simplews

VERSION ?= $(shell git describe --always)

SERVER_PORT ?= 8080

.DEFAULT_GOAL := help
.PHONY: build run docker-build docker-run docker-stop

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ \
	{ printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

build: ## Build bin
	CGO_ENABLED=0 \
	go build \
	-v \
	-ldflags "-s -w -X '$(GIT_REPO)/version.AppVersion=$(VERSION)'" \
	-o $(APPNAME)-$(VERSION) .

run: ## Run app
	SERVER_PORT=$(SERVER_PORT) \
	go run .

docker-build: ## Build docker image
	docker build \
	--pull \
	--build-arg GOLANG_VERSION="$(GOLANG_VERSION)" \
	--build-arg ALPINE_VERSION="$(ALPINE_VERSION)" \
	--build-arg APPNAME="$(APPNAME)" \
	--build-arg VERSION="$(VERSION)" \
	--tag="$(DOCKER_REPO)/$(APPNAME):$(VERSION)" \
	--tag="$(DOCKER_REPO)/$(APPNAME):latest" \
	.

docker-run: ## Run docker
	docker run --rm -d \
	--env SERVER_PORT=$(SERVER_PORT) \
	-p $(SERVER_PORT):$(SERVER_PORT) \
	--name $(APPNAME) \
	$(DOCKER_REPO)/$(APPNAME):latest && \
	docker ps

docker-stop: ## Stop docker
	docker stop $(APPNAME)

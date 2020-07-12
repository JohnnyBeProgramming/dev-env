# ----------------------------------------------------------------------------------------------------------------------
# Makefile - Application Command Configuration
# ----------------------------------------------------------------------------------------------------------------------
# Make Global Defaults
.PHONY: *
.DEFAULT_GOAL := help
SHELL := /bin/sh

IMAGE_NAME ?= johnnybedockered/firefox
IMAGE_TAG ?= latest

# ----------------------------------------------------------------------------------------------------------------------
# Define Commands
# ----------------------------------------------------------------------------------------------------------------------

clean: # Remove compiled artifacts
	@docker rmi -f $(IMAGE_NAME):$(IMAGE_TAG) || true
	
build: # Build all components as production ready assets
	@docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

publish: # Publish the containers and artifacts
	@docker push $(IMAGE_NAME):$(IMAGE_TAG)

dev: # Start in development mode
	@docker run -it --rm \
		-v $(PWD):/workspace \
		-e USER_ID=`id -u ${USER}` \
		-e GROUP_ID=`id -g ${USER}` \
		-e GIT_USER=`git config user.name` \
		-e GIT_EMAIL=`git config user.email` \
		-v ~/.ssh:/home/sandbox/.ssh \
		-v /var/run/docker.sock:/var/run/docker.sock \
		$(IMAGE_NAME):$(IMAGE_TAG)

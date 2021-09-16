IMAGE_NAME := ghcr.io/albertobarba/sam-local
DATE := $(shell date '+%Y-%m-%d')

lint:
	@hadolint Dockerfile

build:
	@docker build -t ${IMAGE_NAME}:dev .

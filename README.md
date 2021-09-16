# SAM local docker

It contains:
 - AWS CLI
 - AWS SAM CLI
 - AWS SAM LOCAL API WRAPPER

## How to use it

### Create a new project

```bash
docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:${PWD} -w ${PWD} ghcr.io/albertobarba/sam-local sam init
```

### Start local API

```bash
docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:${PWD} -w ${PWD} -p 3000:3000 ghcr.io/albertobarba/sam-local sam-local-start-api-wrapper --debug
```

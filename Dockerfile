ARG REGISTRY_PROXY_PREFIX=''

FROM ${REGISTRY_PROXY_PREFIX}amazon/aws-cli:2.2.38 AS aws_img

FROM debian:stable-slim

# Install Dependencies
RUN set -ue \
    ; apt-get update \
    ; apt-get install -y --no-install-recommends --no-install-suggests \
        openssh-client \
        git \
        make \
        curl \
        wget \
        jq \
        ca-certificates \
        unzip \
        groff \
        less \
        iputils-ping \
        iproute2 \
    ; rm -rf /var/lib/apt/lists/* \
;

# Install AWS CLI
COPY --from=aws_img /usr/local/aws-cli /usr/local/aws-cli
RUN set -ue \
    ; ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws \
    ; ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer \
;

# Install SAM CLI
ARG SAM_CLI_VERSION=1.31.0
ENV SAM_CLI_TELEMETRY=0
ARG SAM_ZIP_FILE=aws-sam-cli-linux-x86_64.zip
RUN set -ue \
    ; curl -Lk "https://github.com/aws/aws-sam-cli/releases/download/v$SAM_CLI_VERSION/aws-sam-cli-linux-x86_64.zip" -o "$SAM_ZIP_FILE" \
    ; unzip "$SAM_ZIP_FILE" -d sam-installation \
    ; ./sam-installation/install \
    ; rm -rf "$SAM_ZIP_FILE" sam-installation \
;

COPY ./bin/sam-local-start-api-wrapper /usr/local/bin/
FROM alpine:3.8

ARG KOPS_VERSION=1.13.0
ARG KUBECTL_VERSION=1.13.9
ARG TERRAFORM_VERSION=0.11.14

RUN apk add --no-cache --update  \
    bash \
    ca-certificates \
    curl \
    git \
    jq \
    nodejs \
    nodejs-npm \
    python \
    py-pip \
    vim \
    && pip install awscli \
    && npm install --unsafe-perm -g jfyne/grpcc

RUN curl -SsL --retry 5 \
    "https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64" \
    > /usr/local/bin/kops \
    && chmod +x /usr/local/bin/kops

RUN curl -SsL --retry 5 \
    "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -SsL --retry 5 \
    "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    > /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /usr/local/bin \
    && rm /tmp/terraform.zip

RUN apk --purge -v del curl py-pip \
    && rm /var/cache/apk/*

WORKDIR /covr

COPY entrypoint.sh /covr/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

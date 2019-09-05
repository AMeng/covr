FROM alpine:3.10

ARG KOPS_VERSION=1.13.0
ARG KUBECTL_VERSION=1.13.9
ARG TERRAFORM_VERSION=0.11.14
ARG EVANS_VERSION=0.8.2

RUN apk add --no-cache --update  \
    bash \
    ca-certificates \
    curl \
    git \
    jq \
    python \
    py-pip \
    vim \
    && pip install awscli

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

RUN curl -SsL --retry 5 \
    "https://github.com/ktr0731/evans/releases/download/${EVANS_VERSION}/evans_linux_amd64.tar.gz" \
    > /tmp/evans.tar.gz \
    && tar xvzf /tmp/evans.tar.gz evans -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/evans \
    && rm /tmp/evans.tar.gz

WORKDIR /covr

COPY entrypoint.sh /covr/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

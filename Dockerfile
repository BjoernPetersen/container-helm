FROM debian:bookworm-slim

LABEL org.opencontainers.image.description="Container image based on Debian with kubectl and helm installed."
LABEL org.opencontainers.image.source="https://github.com/BjoernPetersen/container-helm"
LABEL org.opencontainers.image.url="https://github.com/BjoernPetersen/container-helm"

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    ca-certificates \
    curl \
    gettext-base \
    gpg \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# renovate: datasource=github-releases depName=jq packageName=jqlang/jq
ARG JQ_VERSION=1.7.1
RUN curl -sSL https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-$(dpkg --print-architecture) -o /usr/local/bin/jq \
    && chmod +x /usr/local/bin/jq

# renovate: datasource=github-releases depName=yq packageName=mikefarah/yq
ARG YQ_VERSION=v4.45.1
RUN curl -sSL https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_$(dpkg --print-architecture) -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# renovate: datasource=github-releases depName=helm packageName=helm/helm
ARG HELM_VERSION=v3.17.2

WORKDIR /tmp
RUN curl -sSL https://get.helm.sh/helm-${HELM_VERSION}-linux-$(dpkg --print-architecture).tar.gz -o helm.tar \
    && tar -xzf helm.tar \
    && mv linux-$(dpkg --print-architecture)/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -r helm.tar linux-*

# renovate: datasource=github-releases depName=kubernetes packageName=kubernetes/kubernetes
ARG KUBERNETES_VERSION=v1.32.3
RUN curl -sSL https://dl.k8s.io/release/${KUBERNETES_VERSION}/bin/linux/$(dpkg --print-architecture)/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

WORKDIR /

ENTRYPOINT [ "helm" ]

FROM bitnami/kubectl:1.30.3-debian-12-r5

USER root

RUN install_packages curl gettext-base gpg jq

# renovate: datasource=github-releases depName=mikefarah/yq
ARG YQ_VERSION=v4.44.3

RUN curl -sSL https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_$(dpkg --print-architecture) -o /usr/bin/yq \
    && chmod +x /usr/bin/yq

# renovate: datasource=github-releases depName=helm/helm
ARG HELM_VERSION=v3.15.3

WORKDIR /tmp
RUN curl -sfL https://get.helm.sh/helm-${HELM_VERSION}-linux-$(dpkg --print-architecture).tar.gz -o helm.tar \
    && tar -xzf helm.tar \
    && mv linux-$(dpkg --print-architecture)/helm /usr/local/bin/helm \
    && rm -r helm.tar linux-*

WORKDIR /

ENTRYPOINT [ "helm" ]

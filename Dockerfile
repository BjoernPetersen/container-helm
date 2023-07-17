FROM bitnami/kubectl:1.27-debian-11

USER root

RUN install_packages curl

ARG HELM_VERSION=3.12.1

WORKDIR /tmp
RUN curl -sfL https://get.helm.sh/helm-v${HELM_VERSION}-linux-$(dpkg --print-architecture).tar.gz -o helm.tar \
    && tar -xzf helm.tar \
    && mv linux-$(dpkg --print-architecture)/helm /usr/local/bin/helm \
    && rm -r helm.tar linux-*

WORKDIR /

ENTRYPOINT [ "helm" ]

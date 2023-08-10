FROM bitnami/kubectl:1.27-debian-11

USER root

RUN install_packages curl gettext-base

ARG HELM_VERSION=v3.12.3

WORKDIR /tmp
RUN curl -sfL https://get.helm.sh/helm-${HELM_VERSION}-linux-$(dpkg --print-architecture).tar.gz -o helm.tar \
    && tar -xzf helm.tar \
    && mv linux-$(dpkg --print-architecture)/helm /usr/local/bin/helm \
    && rm -r helm.tar linux-*

WORKDIR /

ENTRYPOINT [ "helm" ]

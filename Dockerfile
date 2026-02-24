FROM alpine

ARG KUBECTL_VERSION

RUN echo "Kubectl version is: ${KUBECTL_VERSION}" && \
    export http_proxy=${PROXY_SERVER} && \
    export https_proxy=${PROXY_SERVER} && \
    apk add --update --virtual .build-deps curl && \
    curl -sL https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz | tar -xz kubernetes/client/bin/kubectl && \
    mv ./kubernetes/client/bin/kubectl /usr/bin/ && \
    rm -rf ./kubernetes && \
    apk del .build-deps && \
    apk add --no-cache gettext
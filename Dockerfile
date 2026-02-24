FROM alpine

ARG KUBECTL_VERSION

RUN echo "Kubectl version is: ${KUBECTL_VERSION}" && \
    export http_proxy=${PROXY_SERVER} && \
    export https_proxy=${PROXY_SERVER} && \
    apk add --update --virtual .build-deps curl && \
    curl -sL https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz | tar -xz kubernetes/client/bin/kubectl && \
    mv ./kubernetes/client/bin/kubectl /usr/bin/ && \
    rm -rf ./kubernetes && \
    KUSTOMIZE_VERSION=$(curl -sL https://api.github.com/repos/kubernetes-sigs/kustomize/releases | grep '"tag_name": "kustomize/' | head -1 | sed 's/.*kustomize\/\(v[^"]*\).*/\1/') && \
    echo "Kustomize version is: ${KUSTOMIZE_VERSION}" && \
    curl -sL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" | tar -xz -C /usr/bin/ kustomize && \
    apk del .build-deps && \
    apk add --no-cache gettext
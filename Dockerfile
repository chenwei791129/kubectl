FROM alpine

ARG KUBECTL_VERSION
ARG TARGETARCH

RUN echo "Kubectl version is: ${KUBECTL_VERSION}" && \
    apk add --update --virtual .build-deps curl git && \
    # kubectl
    curl -sL https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-${TARGETARCH}.tar.gz | tar -xz kubernetes/client/bin/kubectl && \
    mv ./kubernetes/client/bin/kubectl /usr/bin/ && \
    rm -rf ./kubernetes && \
    # kustomize
    KUSTOMIZE_VERSION=$(curl -sL https://api.github.com/repos/kubernetes-sigs/kustomize/releases | grep '"tag_name": "kustomize/' | head -1 | sed 's/.*kustomize\/\(v[^"]*\).*/\1/') && \
    echo "Kustomize version is: ${KUSTOMIZE_VERSION}" && \
    curl -sL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${TARGETARCH}.tar.gz" | tar -xz -C /usr/bin/ kustomize && \
    # helm
    HELM_VERSION=$(curl -sL https://api.github.com/repos/helm/helm/releases/latest | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/') && \
    echo "Helm version is: ${HELM_VERSION}" && \
    curl -sL "https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz" | tar -xz -C /usr/bin/ --strip-components=1 linux-${TARGETARCH}/helm && \
    # helm-diff plugin
    helm plugin install --verify=false https://github.com/databus23/helm-diff && \
    # yq
    YQ_VERSION=$(curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/') && \
    echo "yq version is: ${YQ_VERSION}" && \
    curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH}" -o /usr/bin/yq && \
    chmod +x /usr/bin/yq && \
    apk del .build-deps && \
    apk add --no-cache gettext

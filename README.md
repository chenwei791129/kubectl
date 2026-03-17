[![Build and push image when new tag](https://github.com/chenwei791129/k8s-cd-image/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/chenwei791129/k8s-cd-image/actions/workflows/build-and-push.yml)

# k8s-cd-image

Alpine-based Docker image with Kubernetes CD tools for CI/CD pipelines.

## Included Tools

| Tool | Description |
|------|-------------|
| **kubectl** | Kubernetes CLI (version pinned via build arg) |
| **kustomize** | Kubernetes configuration customization (latest) |
| **helm** | Kubernetes package manager (latest) |
| **helm-diff** | Helm plugin for diffing releases |
| **envsubst** | Environment variable substitution (via gettext) |

## Usage

```bash
# Pull from GHCR
docker pull ghcr.io/chenwei791129/k8s-cd-image:latest

# Run kubectl
docker run --rm ghcr.io/chenwei791129/k8s-cd-image:latest kubectl version --client

# Run helm
docker run --rm ghcr.io/chenwei791129/k8s-cd-image:latest helm version

# Run kustomize
docker run --rm ghcr.io/chenwei791129/k8s-cd-image:latest kustomize version
```

## Build

```bash
docker buildx build \
  --build-arg KUBECTL_VERSION=v1.35.1 \
  --platform linux/amd64,linux/arm64 \
  -t k8s-cd-image:latest .
```

## Supported Platforms

- `linux/amd64`
- `linux/arm64`

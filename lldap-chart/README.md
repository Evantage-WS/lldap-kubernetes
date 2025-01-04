# lldap Helm Chart

A Helm chart for deploying [lldap](https://github.com/nitnelave/lldap) a lightweight LDAP server on Kubernetes.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Uninstallation](#uninstallation)
- [Configuration](#configuration)
- [Parameters](#parameters)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- Kubernetes cluster 
- Helm

## Installation

1. **Add the Helm repository** (if hosted in a repository):

   ```bash
        echo "not available at the moment"
   ```

2. **Install the chart**:

   ```bash
    helm install lldap ./lldap-chart --namespace lldap-namespace

   ```


## Uninstallation

To uninstall/delete the `lldap` deployment:

```bash
helm uninstall lldap  -n lldap-namespace
```

The command removes all Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the lldap chart and their default values.

### Parameters

| Parameter                               | Description                                                  | Default Value                         |
|-----------------------------------------|--------------------------------------------------------------|---------------------------------------|
| `replicaCount`                          | Number of replicas                                           | `1`                                   |
| `image.repository`                      | Image repository                                             | `"nitnelave/lldap"`                   |
| `image.tag`                             | Image tag                                                    | `"latest"`                            |
| `image.pullPolicy`                      | Image pull policy                                            | `"IfNotPresent"`                      |
| `env.TZ`                                | Timezone for the application                                 | `"CET"`                               |
| `env.GID`                               | Group ID                                                     | `"1001"`                              |
| `env.UID`                               | User ID                                                      | `"1001"`                              |
| `persistence.enabled`                   | Enable persistent storage                                    | `true`                                |
| `persistence.storageClassName`          | Storage class name                                           | `""`                                  |
| `persistence.storageSize`               | Storage size                                                 | `"100Mi"`                             |
| `persistence.accessMode`                | Access mode for the PVC                                      | `"ReadWriteOnce"`                     |
| `persistence.localPath`                 | Local filesystem path for storage                            | `""`                                  |
| `persistence.manualProvision`           | Manually provision a PersistentVolume                        | `false`                               |
| `resources`                             | Resource limits and requests                                 | `{}`                                  |
| `nodeSelector`                          | Node labels for pod assignment                               | `{}`                                  |
| `tolerations`                           | Tolerations for pod assignment                               | `[]`                                  |
| `affinity`                              | Affinity for pod assignment                                  | `{}`                                  |
| `hpa.enabled`                           | Enable Horizontal Pod Autoscaler (HPA)                       | `true`                                |
| `hpa.minReplicas`                       | Minimum number of replicas                                   | `1`                                   |
| `hpa.maxReplicas`                       | Maximum number of replicas                                   | `3`                                   |
| `hpa.targetCPUUtilizationPercentage`    | Target CPU utilization percentage for HPA                    | `60`                                  |
| `hpa.targetMemoryUtilizationPercentage` | Target memory utilization percentage for HPA                 | `60`                                  |
| `service.name`                          | Name of the Kubernetes service                               | `"lldap-service"`                     |
| `service.type`                          | Service type                                                 | `"ClusterIP"`                         |
| `service.ports`                         | List of service ports                                        | See `values.yaml`                     |
| `ingress.enabled`                       | Enable Ingress                                               | `false`                               |
| `ingress.name`                          | Name of the Ingress resource                                 | `"lldap-web-ingress"`                 |
| `ingress.ingressClassName`              | Ingress class name                                           | `"nginx"`                             |
| `ingress.annotations`                   | Annotations for the Ingress                                  | `{}`                                  |
| `ingress.labels`                        | Labels for the Ingress                                       | `{}`                                  |
| `ingress.hosts`                         | List of host configurations                                  | See `values.yaml`                     |
| `ingress.tls`                           | TLS configuration for the Ingress                            | See `values.yaml`                     |
| `secret.create`                         | Create a new secret for credentials                          | `true`                                |
| `secret.name`                           | Name of the secret                                           | `"lldap-credentials"`                 |
| `secret.lldapJwtSecret`                 | JWT secret for LLDAP                                         | `"wobY6RK/Dc0vL21zFiIZs9iyVy0NQ3ldijYPQ4HLWTc="` |
| `secret.lldapUserName`                  | Username for the LDAP user                                   | `"admin"`                             |
| `secret.lldapUserPass`                  | Password for the LDAP user                                   | `"admiistrator123456"`                |
| `secret.lldapBaseDn`                    | Base DN for LDAP                                             | `"dc=homelab,dc=es"`                  |
| `secret.useExisting`                    | Use an existing secret                                       | `false`                               |
| `secret.existingSecretName`             | Name of the existing secret                                  | `""`                                  |

### How to Configure

You can specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```bash
helm install my-ldapp ./lldap-chart \
  --set replicaCount=2 \
  --set image.tag=latest \
  --set persistence.enabled=false
```

Alternatively, you can provide a YAML file with custom values:

```bash
helm install my-ldapp ./lldap-chart -f custom-values.yaml
```

Thanks for taking your time to reading!

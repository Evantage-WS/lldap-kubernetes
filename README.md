# Using the Light LDAP (LLDAP) implementation for authentication on Kubernetes

LLDAP homepage: https://github.com/nitnelave/lldap

## About

For testing purposes you can run the LLDAP container on Kubernetes and use the
container as a LDAP authentication backend.

Thanks to nitnelave for the changing LLDAP to get it authenticating with SUSE
Rancher (see https://github.com/nitnelave/lldap/issues/432)

## Set the variables needed and create Kubernetes secret of it

The LLDAP container will be using thes secrets, without creating these
secrets, the pod will not be up and running

```
NAMESPACE=lldap # in which namespace the lldap container will be installed, always use lowercase
LLDAP_JWT_SECRET=<some random value>
LLDAP_LDAP_USER_PASS=admin # change if wanted
LLDAP_BASE_DN=dc=evantage,dc=nl # set your own is wanted

kubectl create secret generic lldap-credentials \
  --from-literal=lldap-jwt-secret=${LLDAP_JWT_SECRET} \
  --from-literal=lldap-ldap-user-pass=${LLDAP_LDAP_USER_PASS} \
  --from-literal=base-dn=${LLDAP_BASE_DN} \
  -n ${NAMESPACE}
```

## Apply the yaml files

A PVC will be used to store the data persistant. It will use the local path provisioner,
see https://github.com/rancher/local-path-provisioner. If it is not installed, please
install this prior to applying the LLDAP yaml files.

Apply the LLDAP deployment in the same namespace as where the secrets were created:

```
kubectl apply -f lldap-persistentvolumeclaim.yaml -n ${NAMESPACE}
kubectl apply -f lldap-deployment.yaml -n ${NAMESPACE}
kubectl apply -f lldap-service.yaml -n ${NAMESPACE}
```

It will take maybe a minute or so, after pulling the image it will be up and running.

Your LLDAP container is then ready for accepting LDAP requests on port 3890.

## Accessing the UI

To add user and groups to LLDAP, you can use the UI of LLDAP. You can use a kubectl
port-forward on the service to get to this UI:
```
kubectl port-forward service/lldap-service 17170:17170 -n ${NAMESPACE}
```

And in your browser go to http://127.0.0.1:17170. Login with admin and the password set in variable above.

For creating user and groups, please look at the LLDAP documentation at https://github.com/nitnelave/lldap

Good luck!

## Using the helm chart

### Required values and recommended values

Always create your own secrets and usernames:
```yaml
secret:
  lldapJwtSecret: "replace-me"
  lldapUserName: "admin" # this has a default value but can be overridden
  lldapUserPass: "replace-me"
  lldapBaseDn: "dc=homelab,dc=home" # this has a default value but can be overridden
```

Set your own ingress values:
```yaml
ingress:
  enabled: true
  ingressClassName: nginx
  annotations: {}
  labels: {}
  hosts:
    - host: "lldap.test.com"
      paths:
        - path: "/"
          pathType: "Prefix"
  tls:
    - secretName: "lldap-secret-tls"
      hosts:
        - "lldap.test.com"
```

### Install the chart

```bash
```
helm install lldap-chart https://github.com/Evantage-WS/lldap-kubernetes/releases/download/lldap-chart-0.3.4/lldap-chart-0.3.4.tgz
```

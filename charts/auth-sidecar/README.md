# Auth-Sidecar

This helm chart deploy one pod with two containers.
The first container is the sidecar for authentication based on oauth2 mechanism. The second container is the target service it self.


## How to deploy

### Prequirements

You need follow software and access to deploy the helm chart

- helm 3.x (https://helm.sh)
- access to kubernetes cluster api server (tested with minikube)
- The OIDC Client_ID from IDP System (oauth2.secret.OIDC_CLIENT_ID)
- The IDP Discovery URL (oauth2.config.OIDC_DISCOVERY_URL)

### Deployment

```bash
# from git root directory go into the charts folder (aws-helm-service-chart/charts)
cd charts
export CLIENTID="__CLIENTID__"
export DISCOVERY_URL="__URL__"
export AUTHSERVICE_DOCKER_REPOSITORY="localhost:5000"
export SERVICE_DOCKER_REPOSITORY="localhost:5000"
export SERVICE_IMAGE_NAME="nginx"
export SERVICE_IMAGE_VERSION="alpine"

helm install servicename \
  --set oauth2.secret.OIDC_CLIENT_ID="${CLIENTID}" \
  --set oauth2.config.OIDC_DISCOVERY_URL="${DISCOVERY_URL}" \
  --set auth_service.image.repository="${AUTHSERVICE_DOCKER_REPOSITORY}" \
  --set target_service.image.repository="${SERVICE_DOCKER_REPOSITORY}" \
  --set target_service.image.name="${SERVICE_IMAGE_NAME}" \
  --set target_service.image.version="${SERVICE_IMAGE_VERSION}" \
  ./auth-sidecar
```

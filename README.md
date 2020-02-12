# aws-helm-service-chart

This chart facilitats the deployment of sample microservice projects. The chart supports the deployment of backend (Spring Boot) services as well as
ui based services (vue). Note that as of now there are no external dependencies added.

## Install the chart

Install the chart with the release name `my-release`

```bash
helm install \
    --set=image.repository=$REPOSITORY_URI \
    --set=ingress.hosts={$INGRESS_HOST} \
    --set=namespace.name=$NAMESPACE \
    --name=my-release
```

The command deploys a default backend Spring Boot microservice on the Kubernetes cluster in the default namespace.
See the [configuration](#Configuration) section for a detailed overview of parameters.

## Uninstall the chart

To uninstall the `my-release` deployment type:

```bash
helm delete --purge my-release
```

## Configuration

The chart can be executed with following parameters:

| Parameter                     | Description   | Example  |
| :---------------------------- |:--------------| :-----   |
| image.repository              | The name of the AWS ECR image repository to deploy artifacts to. The repository url needs to be provided in the following form: <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/<REPOSITORY_NAME> | `111122223333.dkr.ecr.eu-west-1.amazonaws.com/my-repo` |
| ingress.host                  | A valid DNS name for exposing an ingress route for public access. | `my-service.demo.com` |
| project.includeAwsCredentials | If AWS credentials need to be provided for using other AWS services internally set this flag to `true`. When set to `true` then `secret.aws_accesskey` and `secret.aws_secretkey` need to be provided as well. | `true` if AWS credentials should be included, `false` is the default.|
| secret.aws_accesskey          | It might be necessary to additionally pass the AWS Access Key when using internal AWS services from within your application.  |  AWS Access Key generated for your user  |
| secret.aws_secretkey          | It might be necessary to additionally pass the AWS Secret Key when using internal AWS services from within your application.  |  AWS Secret Key generated for your user  |
| namespace.name                | The name of an existing namespace the service should be deployed to. | `default` |
| resources.limits.cpu          | Total amount of CPU time that a container can use every 100 ms. See [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for a detailed description on resource usage.| `1000m` |
| resources.limits.memory       | The memory limit for a Pod. See [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for a detailed description on resource usage. | `512M` |
| resources.requests.cpu        | Fractional amount of CPU allowed for a Pod. See [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for a detailed description on resource usage.| `250m` |
| resources.requests.memory     | Amount of memory reserved for a Pod. See [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) for a detailed description on resource usage. | `256M` |

In order to configure your service to work properly with this chart have a look at [sample deployment on AWS](https://github.com/remote-collab/remote-collab-sample-ui/blob/master/README.md).
                                                                                                                  

## Upload the chart to the chart repository

1. Change the versions in `Chart.yaml` according to the principle of [semantic versioning](https://semver.org/).

2. Next package the chart by typing in `helm package .` in the project's root folder.

3. Push the newly packaged jar to your chart repo
    ```
    helm s3 push aws-helm-service-chart-1.2.2.tgz <CHART_REPO>
    ```

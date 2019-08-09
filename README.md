# viper-aws-helm-service-chart

This chart facilitats the deployment of viper based microservices. The chart supports the deployment of backend (Spring Boot) services as well as
ui based services (vue).

## Install the chart

Install the chart with the release name `my-release`

```bash
helm install \
    --set=image.repository=$REPOSITORY_URI,image.name=$SERVICE_NAME \
    --set=secret.keystore=$KEYSTORE,secret.password=$KEYSTORE_PASS \
    --set=ingress.hosts={$INGRESS_HOST} \
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
| image.repository              | The name of the AWS ECR image repository to deploy artifacts to. The repository url needs to be provided in the following form: <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com/<REPOSITORY_NAME> | `111122223333.dkr.ecr.eu-west-1.amazonaws.com/viper` |
| image.name                    | The name of the image to deploy to the AWS ECR repository. Usually the name of the service is used as image name. Note that a repository with proper repo url and image name need to be created in AWS ECR before. | `my-service` |
| secret.keystore               | A default TLS enabled Spring Boot microservice will need a valid keystore file for gathering cert and key references. Make sure to provide a `base64` encoded value. | KEYSTORE = echo -n <KEYSTORE_FILE> &#124;base64)   |
| secret.password               | The keystore password retrieved when generating the keystore file. | `some secret password` |
| secret.ui_crt                 | When deploying a UI microservice a certificate is needed for Nginx TLS support. | Enter a valid certificate as helm argument with name `ui.crt` |
| secret.ui_key                 | When deploying a UI microservice a certificate key is needed for Nginx TLS support. | Enter a valid certificate key as helm argument with name `ui.key` |
| secret.secret.aws_accesskey   | It might be necessary to additionally pass the AWS Access Key when using internal AWS services from within your application.  |  AWS Access Key generated for your user  |
| secret.secret.aws_secretkey   | It might be necessary to additionally pass the AWS Secret Key when using internal AWS services from within your application.  |  AWS Secret Key generated for your user  |
| ingress.hosts                 | A valid DNS name for exposing an ingress route for public access. | `my-service.demo.com` |
| project.type                  | The type of project to be deployed. | Valid values are either `ui` or `backend` |
| project.includeAwsCredentials | If AWS credentials need to be provided for using other AWS services internally set this flag to `true`. When set to `true` then `secret.secret.aws_accesskey` and `secret.secret.aws_secretkey` need to be provided as well. | `true` if AWS credentials should be included, `false` is the default.|

In order to configure your service to work properly with this chart have a look at [how to deploy a viper service on AWS](https://github.com/visual-perceptibility/viper-service-remote-collab-admin/blob/master/README.md).
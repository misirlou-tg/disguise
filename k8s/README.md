# Exploring Kubernetes

These are kubernetes manifest/resource files I used when exploring how to deploy
Disguise on kubernetes.

## Applying

There are two ways to apply/deploy the application, as multiple pods or as
a single pod.

### Multiple Pods

This has two deployments, one for `web` (nginx) and one for `mbtest`,
`mbtest-service` is used to connect the two.

``` sh
# Deploy mbtest-service first, when web/nginx starts it will do a DNS lookup
kubectl apply -f multi-pod/mbtest-service.yaml
kubectl apply -f multi-pod/mbtest-deployment.yaml
kubectl apply -f multi-pod/web-deployment.yaml
kubectl apply -f web-service.yaml
```

### Single Pod

This deployment only specifies one pod and adds both the `web` (nginx) and `mbtest`
processes as containers connected via internal networking.

``` sh
kubectl apply -f one-pod/disguise-deployment.yaml
kubectl apply -f web-service.yaml
```

## Web Service

The [`web-service.yaml`](web-service.yaml) is specified as type `LoadBalancer`
because I wanted it to be "externally visible" on docker desktop. It also has
an AWS specific annotation to create an internal load balancer (I tested it on
a VPC that only had private subnets). See the yaml file for important comments.

Deploying the service is not required if you use [port forwarding][port-forward]
to forward a local port on a development machine to the deployment/pod.

[port-forward]: https://kubernetes.io/docs/reference/kubectl/generated/kubectl_port-forward/ "kubectl port-forward"

# Covr GRPC K8S

Deploy a simple GRPC service to Kubernetes with Kops and Terraform.

### Setup

The project requires AWS credentials to be set in the `env.list` file.

### Demo

To run a demo that deploys the application and verifies the endpoints:
```
make demo_up
```

When the script exits, the demo has finished successfully. To tear down the infrastructure, just
run:
```
make demo_down
```

## Project Details

The entire project can be run from within the provided docker container. You can drop into a shell
with:
```
make attach
```

### How the demo works
1. Run the bootstrap Terraform project to create an S3 bucket for kops.
2. Run kops to create a small k8s cluster (3 masters, 3 workers).
3. Wait for the k8s cluster to be in a valid state.
4. Run the main Terraform project to create SSL certs and add a TLS endpoint to the service's NLB.
5. Run a script to validate both TCP and TLS endpoints.

### Notes
* The version of Kubernetes (1.13) was chosen because it is the latest version supported by an
  official kops release.
* I chose to use a self-signed certificate which lead to a few challenges:
  1. Kubernetes 1.13 does not support TLS endpoints on NLB's (This has been added in 1.15). To get
     around this I add the endpoint within Terraform.
  2. The `grpcc` CLI tool doesn't work with self-signed certs, so I switched to [`evans`][evans].

[evans]: https://github.com/ktr0731/evans

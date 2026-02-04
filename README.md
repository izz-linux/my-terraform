# Terraform Modules

Multi-cloud Terraform modules for infrastructure deployment.

## Available Modules

| Cloud | Module | Description |
|-------|--------|-------------|
| Azure | [azure-aks](./azure-aks) | Azure Kubernetes Service (AKS) |
| GCP | [gcp-dataproc](./gcp-dataproc) | Google Cloud Dataproc clusters |
| AWS | Coming soon | Amazon Elastic Kubernetes Service (EKS) |
| GCP | Coming soon | Google Kubernetes Engine (GKE) |

## Usage

Each module has its own directory with Terraform files and examples.

```hcl
module "aks" {
  source = "github.com/izz-linux/my-terraform-modules//azure-aks"
  # ...
}

module "dataproc" {
  source = "github.com/izz-linux/my-terraform-modules//gcp-dataproc"
  # ...
}
```

See individual module READMEs for detailed usage instructions.

## License

See [LICENSE](./LICENSE) for details.

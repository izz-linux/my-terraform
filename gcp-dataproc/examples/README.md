# Basic Dataproc Example

This example demonstrates basic usage of the GCP Dataproc module.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.12.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- A GCP project with Dataproc API enabled

## Usage

1. Authenticate with GCP:

```bash
gcloud auth application-default login
gcloud config set project <project-id>
```

2. Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Edit `terraform.tfvars` with your desired values.

4. Initialize and apply:

```bash
terraform init
terraform plan
terraform apply
```

## Clean Up

To destroy the resources:

```bash
terraform destroy
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.33 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dataproc"></a> [dataproc](#module\_dataproc) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.staging_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.temp_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

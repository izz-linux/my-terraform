# PENN Interactive's Dataproc Module
# terraform-google-cloud-dataproc
This repository is to be used as a terraform modulle for creating a Google Cloud Dataproc cluster. It is part of the [thescore-terraform-modules](https://github.com/thescore-terraform-modules) organization, which contains Terraform modules for various Google Cloud resources.

## Getting Started
Read the [Terraform documentation](https://developer.hashicorp.com/terraform/docs) to get started with Terraform.

1. Ensure you create unique GCS buckets for storing dataproc staging data, as the bucket name must be globally unique. If you do not provide a `staging_bucket` variable, the module will automatically create a bucket for you, and most likely will be shared with other dataproc clusters. 
2. The above is true for `temporary_bucket` as well, which is used for storing temporary data during the cluster creation process. If you do not provide a `temporary_bucket` variable, the module will automatically create a bucket for you, and most likely will be shared with other dataproc clusters.

## Example Usage
A provided example demonstrates how to use this module to create a Dataproc cluster. You can find the example in the [examples](https://github.com/thescore-terraform-modules/terraform-google-cloud-dataproc/tree/main/examples) directory.

## Documentation and Further Reading
- [Publishing Private Modules to TFC](https://developer.hashicorp.com/terraform/cloud-docs/registry/publish-modules)
- [Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_dataproc_autoscaling_policy.asp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataproc_autoscaling_policy) | resource |
| [google_dataproc_cluster.gce_based_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataproc_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_delete_time"></a> [auto\_delete\_time](#input\_auto\_delete\_time) | Time after which the cluster will be automatically deleted | `string` | `"259200s"` | no |
| <a name="input_basic_algorithm"></a> [basic\_algorithm](#input\_basic\_algorithm) | Configuration for basic autoscaling algorithm | <pre>object({<br>    cooldown_period = string<br>    yarn_config = object({<br>      graceful_decommission_timeout = string<br>      scale_down_factor             = number<br>      scale_up_factor               = number<br>    })<br>  })</pre> | <pre>{<br>  "cooldown_period": "120s",<br>  "yarn_config": {<br>    "graceful_decommission_timeout": "3600s",<br>    "scale_down_factor": 1,<br>    "scale_up_factor": 0.05<br>  }<br>}</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the Dataproc cluster | `string` | `null` | no |
| <a name="input_enable_lifecycle_config"></a> [enable\_lifecycle\_config](#input\_enable\_lifecycle\_config) | Enable lifecycle configuration for the Dataproc cluster | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | n/a | yes |
| <a name="input_idle_delete_ttl"></a> [idle\_delete\_ttl](#input\_idle\_delete\_ttl) | Time to live for idle clusters before they are deleted | `string` | `"86400s"` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | the image URI for the Dataproc cluster | `string` | `"projects/cloud-dataproc/global/images/dataproc-2-0-deb10-20250116-234030-rc01"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | the image version for the Dataproc cluster | `string` | `"2.0.129-debian10"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to the Dataproc cluster | `map(string)` | n/a | yes |
| <a name="input_master_count"></a> [master\_count](#input\_master\_count) | The number of master instances in the Dataproc cluster | `number` | `3` | no |
| <a name="input_master_machine_type"></a> [master\_machine\_type](#input\_master\_machine\_type) | The machine type for the master instances | `string` | `"n1-standard-4"` | no |
| <a name="input_metric_override"></a> [metric\_override](#input\_metric\_override) | Override properties for the Dataproc cluster metrics | `list(string)` | <pre>[<br>  "hdfs:NameNode:FSNamesystem:BlocksTotal",<br>  "hdfs:NameNode:FSNamesystem:CapacityTotal",<br>  "hdfs:NameNode:FSNamesystem:CapacityUsed",<br>  "hdfs:NameNode:FSNamesystem:CapacityRemaining",<br>  "yarn:ResourceManager:QueueMetrics:AppsRunning",<br>  "yarn:ResourceManager:QueueMetrics:AppsPending"<br>]</pre> | no |
| <a name="input_override_properties"></a> [override\_properties](#input\_override\_properties) | Override properties for the Dataproc cluster | `map(string)` | <pre>{<br>  "capacity-scheduler:yarn.scheduler.capacity.maximum-am-resource-percent": "0.5",<br>  "core:fs.gs.outputstream.sync.min.interval.ms": "10000",<br>  "core:fs.gs.status.parallel.enable": "false",<br>  "dataproc:dataproc.control.max.assigned.job.tasks": "1200",<br>  "dataproc:dataproc.logging.stackdriver.job.driver.enable": "true",<br>  "dataproc:dataproc.logging.stackdriver.job.yarn.container.enable": "true",<br>  "dataproc:dataproc.scheduler.driver-size-mb": "512",<br>  "spark:spark.port.maxRetries": "2000",<br>  "yarn:yarn.nodemanager.resource.detect-hardware-capabilities": "true",<br>  "yarn:yarn.scheduler.maximum-allocation-mb": "71680"<br>}</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the Google Cloud project where the Dataproc cluster will be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the Dataproc cluster will be created | `string` | `"us-central1"` | no |
| <a name="input_secondary_worker_config"></a> [secondary\_worker\_config](#input\_secondary\_worker\_config) | Configuration for secondary worker autoscaling policy | <pre>object({<br>    max_instances = number<br>    min_instances = number<br>    weight        = number<br>  })</pre> | <pre>{<br>  "max_instances": 40,<br>  "min_instances": 0,<br>  "weight": 1<br>}</pre> | no |
| <a name="input_secondary_worker_count"></a> [secondary\_worker\_count](#input\_secondary\_worker\_count) | The number of secondary worker instances in the Dataproc cluster | `number` | `60` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The service account to use for the Dataproc cluster | `string` | `"dataproc-data-lake@non-prod-data-eng-staging.iam.gserviceaccount.com"` | no |
| <a name="input_service_account_scopes"></a> [service\_account\_scopes](#input\_service\_account\_scopes) | Scopes to apply to the service account for the Dataproc cluster | `list(string)` | <pre>[<br>  "https://www.googleapis.com/auth/cloud-platform",<br>  "https://www.googleapis.com/auth/devstorage.read_write",<br>  "https://www.googleapis.com/auth/bigquery",<br>  "https://www.googleapis.com/auth/logging.write"<br>]</pre> | no |
| <a name="input_staging_bucket"></a> [staging\_bucket](#input\_staging\_bucket) | The bucket for storing cluster staging data. If not provided, it will be automatically created. | `string` | `null` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork to use for the Dataproc cluster | `string` | `"projects/non-prod-host-network/regions/us-central1/subnetworks/data-engineering-other-staging"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Network tags to apply to the Dataproc cluster instances | `list(string)` | <pre>[<br>  "dataproc",<br>  "example"<br>]</pre> | no |
| <a name="input_temp_bucket"></a> [temp\_bucket](#input\_temp\_bucket) | The bucket for storing temporary data. If not provided, it will be automatically created. | `string` | `null` | no |
| <a name="input_vault_role"></a> [vault\_role](#input\_vault\_role) | the vault role for the Dataproc cluster | `string` | `"dataproc-data-lake"` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of worker instances in the Dataproc cluster | `number` | `2` | no |
| <a name="input_worker_machine_type"></a> [worker\_machine\_type](#input\_worker\_machine\_type) | The machine type for the worker instances | `string` | `"n1-standard-4"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone where the Dataproc cluster will be created | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_http_ports"></a> [http\_ports](#output\_http\_ports) | n/a |
| <a name="output_master_instance_names"></a> [master\_instance\_names](#output\_master\_instance\_names) | n/a |
| <a name="output_worker_instance_names"></a> [worker\_instance\_names](#output\_worker\_instance\_names) | n/a |
<!-- END_TF_DOCS -->

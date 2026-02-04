variable "cluster_name" {
  type        = string
  description = "The name of the Dataproc cluster"
  default     = null
}

variable "region" {
  type        = string
  description = "The region where the Dataproc cluster will be created"
  default     = "us-central1"
}

variable "master_count" {
  type        = number
  description = "The number of master instances in the Dataproc cluster"
  default     = 3
}

variable "master_machine_type" {
  type        = string
  description = "The machine type for the master instances"
  default     = "n1-standard-4"
}

variable "worker_count" {
  type        = number
  description = "The number of worker instances in the Dataproc cluster"
  default     = 2
}

variable "secondary_worker_count" {
  type        = number
  description = "The number of secondary worker instances in the Dataproc cluster"
  default     = 60
}

variable "worker_machine_type" {
  type        = string
  description = "The machine type for the worker instances"
  default     = "n1-standard-4"
}

variable "env" {
  type        = string
  description = "Environment name"
  validation {
    condition = contains(
      ["dev", "staging", "uat", "audit1", "demo", "ps", "prod", "prod-mirror", "production"],
      var.env,
    )
    error_message = "Invalid environment name."
  }
}

variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project where the Dataproc cluster will be created"
}

variable "labels" {
  type        = map(string)
  description = "Labels to apply to the Dataproc cluster"
  validation {
    condition = contains(
      keys(var.labels),
      "vertical",
      ) && contains(
      keys(var.labels),
      "env",
      ) && contains(
      keys(var.labels),
      "team",
      ) && contains(
      keys(var.labels),
      "service",
      ) && contains(
      keys(var.labels),
      "domain",
    )
    error_message = "Cost Op specific labels: https://thescore.atlassian.net/wiki/spaces/DEVOPS/pages/5433524260/DataDog+Tagging+of+GCP+Resources#Mappings"
  }
}

variable "tags" {
  type        = list(string)
  description = "Network tags to apply to the Dataproc cluster instances"
  default     = ["dataproc", "example"]
}

variable "zone" {
  type        = string
  description = "The zone where the Dataproc cluster will be created"
  default     = "us-central1-a"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to use for the Dataproc cluster"
  default     = "projects/non-prod-host-network/regions/us-central1/subnetworks/data-engineering-other-staging"
}

variable "service_account" {
  type        = string
  description = "The service account to use for the Dataproc cluster"
  default     = "dataproc-data-lake@non-prod-data-eng-staging.iam.gserviceaccount.com"
}

variable "service_account_scopes" {
  type        = list(string)
  description = "Scopes to apply to the service account for the Dataproc cluster"
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/devstorage.read_write",
    "https://www.googleapis.com/auth/bigquery",
    "https://www.googleapis.com/auth/logging.write",
  ]
}

variable "image_uri" {
  type        = string
  description = "the image URI for the Dataproc cluster"
  default     = "projects/cloud-dataproc/global/images/dataproc-2-0-deb10-20250116-234030-rc01"
}

variable "image_version" {
  type        = string
  description = "the image version for the Dataproc cluster"
  default     = "2.0.129-debian10"
}

variable "vault_role" {
  type        = string
  description = "the vault role for the Dataproc cluster"
  default     = "dataproc-data-lake"
}

variable "override_properties" {
  type        = map(string)
  description = "Override properties for the Dataproc cluster"
  default = {
    "capacity-scheduler:yarn.scheduler.capacity.maximum-am-resource-percent" = "0.5"
    "core:fs.gs.outputstream.sync.min.interval.ms"                           = "10000"
    "core:fs.gs.status.parallel.enable"                                      = "false"
    "dataproc:dataproc.control.max.assigned.job.tasks"                       = "1200"
    "dataproc:dataproc.logging.stackdriver.job.driver.enable"                = "true"
    "dataproc:dataproc.logging.stackdriver.job.yarn.container.enable"        = "true"
    "dataproc:dataproc.scheduler.driver-size-mb"                             = "512"
    "spark:spark.port.maxRetries"                                            = "2000"
    "yarn:yarn.nodemanager.resource.detect-hardware-capabilities"            = "true"
    "yarn:yarn.scheduler.maximum-allocation-mb"                              = "71680"
  }
}

variable "metric_override" {
  type        = list(string)
  description = "Override properties for the Dataproc cluster metrics"
  default = [
    "hdfs:NameNode:FSNamesystem:BlocksTotal",
    "hdfs:NameNode:FSNamesystem:CapacityTotal",
    "hdfs:NameNode:FSNamesystem:CapacityUsed",
    "hdfs:NameNode:FSNamesystem:CapacityRemaining",
    "yarn:ResourceManager:QueueMetrics:AppsRunning",
    "yarn:ResourceManager:QueueMetrics:AppsPending"
  ]
}

variable "secondary_worker_config" {
  type = object({
    max_instances = number
    min_instances = number
    weight        = number
  })
  description = "Configuration for secondary worker autoscaling policy"
  default = {
    max_instances = 40
    min_instances = 0
    weight        = 1.0
  }
}

variable "basic_algorithm" {
  type = object({
    cooldown_period = string
    yarn_config = object({
      graceful_decommission_timeout = string
      scale_down_factor             = number
      scale_up_factor               = number
    })
  })
  description = "Configuration for basic autoscaling algorithm"
  default = {
    cooldown_period = "120s"
    yarn_config = {
      graceful_decommission_timeout = "3600s"
      scale_down_factor             = 1.0
      scale_up_factor               = 0.05
    }
  }
}

variable "enable_lifecycle_config" {
  type        = bool
  description = "Enable lifecycle configuration for the Dataproc cluster"
  default     = true
}

variable "idle_delete_ttl" {
  type        = string
  description = "Time to live for idle clusters before they are deleted"
  default     = "86400s" # 1 day
}

variable "auto_delete_time" {
  type        = string
  description = "Time after which the cluster will be automatically deleted"
  default     = "259200s" # 3 days
}

variable "bucket_name_prefix" {
  type        = string
  default     = "dp-data-eng"
  description = "Prefix for the bucket names"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.33"
    }
  }
}

module "dataproc" {
  source                 = "../"
  project_id             = "prod-data-eng-225a"
  cluster_name           = "data-lake-prod-mirror"
  region                 = "us-central1"
  zone                   = "us-central1-a"
  subnetwork             = "projects/prod-host-network/regions/us-central1/subnetworks/data-engineering-other-production"
  master_count           = 3
  master_machine_type    = "n1-standard-4"
  worker_count           = 2
  worker_machine_type    = "n1-standard-4"
  secondary_worker_count = 0 # this will scale up to 40 if needed
  service_account        = "dataproc-data-lake@prod-data-eng-225a.iam.gserviceaccount.com"
  service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  env                    = "prod-mirror"
  labels = {
    env      = "prod-mirror"
    team     = "data-lake"
    service  = "aero"
    vertical = "data"
    domain   = "data-engineering"

  }
  tags          = ["dataproc", "example"]
  image_uri     = "projects/cloud-dataproc/global/images/dataproc-2-0-deb10-20250116-234030-rc01"
  image_version = "2.0.129-debian10"
  vault_role    = "dataproc-data-lake"
  bucket_name_prefix  = "dp-data-eng"
  
  override_properties = {
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

  metric_override = [
    "hdfs:NameNode:FSNamesystem:BlocksTotal",
    "hdfs:NameNode:FSNamesystem:CapacityTotal",
    "hdfs:NameNode:FSNamesystem:CapacityUsed",
    "hdfs:NameNode:FSNamesystem:CapacityRemaining",
    "yarn:ResourceManager:QueueMetrics:AppsRunning",
    "yarn:ResourceManager:QueueMetrics:AppsPending"
  ]
}

output "http_ports" {
  value = google_dataproc_cluster.gce_based_cluster.cluster_config[0].endpoint_config[0].http_ports
}

output "master_instance_names" {
  value = google_dataproc_cluster.gce_based_cluster.cluster_config[0].master_config[0].instance_names
}
output "worker_instance_names" {
  value = google_dataproc_cluster.gce_based_cluster.cluster_config[0].worker_config[0].instance_names
}

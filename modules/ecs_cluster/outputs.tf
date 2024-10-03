output "cluster_id" {
  description = "ID that identifies the cluster"
  value       = try(aws_ecs_cluster.this.id, null)
}
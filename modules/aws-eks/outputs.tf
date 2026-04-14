output "cluster_name" {
  description = "eks cluster name"
  value       = local.cluster_name
}

output "availability_zones" {
  description = "aws availability sones"
  value       = data.aws_availability_zones.available.names
}

output "cluster_version" {
  description = "eks cluster version"
  value       = var.cluster_version
}

# output "private_subnets" {
#   value = 
# }


# output "cluster_endpoint" {
#   description = "control plane endpoint"
#   value       = module.eks.cluster_endpoint
# }

# output "cluster_security_group_id" {
#   description = "control plane security group"
#   value       = local.cluster_security_group_id
# }

# output "cluster_security_group_id" {
#   description = "Security group ID attached to the EKS cluster"
#   value       = aws_eks_cluster.eks_cluster.vpc_config.cluster_security_group_id #     .vpc_config[0].cluster_security_group_id
# }

# output "cluster_primary_security_group_id" {
#   description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
#   value       = try(module.aws-vpc.   , null)
# }

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = aws_eks_cluster.cluster[0].vpc_config[0].cluster_security_group_id
}


# output "subnets" {
#   description = "eks cluster name"
#   value       = module.eks.cluster_name
# }



# output "availability_zones" {
#   description = "aws availability sones"
#   value       = local.availability_zones.names
# }

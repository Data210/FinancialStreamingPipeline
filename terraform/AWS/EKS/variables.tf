variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}


variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
  default     = "finance-pipeline-eks"
}

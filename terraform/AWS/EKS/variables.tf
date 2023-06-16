variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}


variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
  default     = "finance-pipeline-eks"
}

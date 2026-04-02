variable "assume_role_arn" {
  description = "IAM role ARN Cribl Search assumes to read S3 (cross-account or same account)."
  type        = string
}

variable "assume_role_external_id" {
  description = "External ID required by the role trust policy (treat as a secret; do not commit real values to public repos)."
  type        = string
  sensitive   = true
}

variable "s3_investigation_bucket" {
  description = "S3 bucket name (first path segment before version/dataSource/... in Cribl dataset bucket paths)."
  type        = string
}

variable "aws_region" {
  description = "AWS region for S3 datasets (must match where data is stored)."
  type        = string
  default     = "eu-central-1"
}

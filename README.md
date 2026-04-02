# cribl_securityinvestigations

# Set up Cribl Cloud components using terraform

## Prerequisites
It obviously needs Terraform ;)

### Install terraform
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## Setup
The providers works with env variables, but can work with credential files, as in the [example here](https://github.com/criblio/terraform-provider-criblio/tree/main?tab=readme-ov-file#authentication-methods). Change the `main.tf` file accordingly, if needed.

Client ID and client secret are available under Organization -> API Credentials. Requires Admin permissions.

### Environment variables setup
```bash
export CRIBL_CLIENT_ID="your-client-id"
export CRIBL_CLIENT_SECRET="your-client-secret"
export CRIBL_ORGANIZATION_ID="your-organization-id"
export CRIBL_WORKSPACE_ID="your-workspace-id"

# Optional: specify another cloud domain (defaults to cribl.cloud)
export CRIBL_CLOUD_DOMAIN="cribl-staging.cloud"

```

## Terraform variables

AWS assume-role settings and the S3 bucket name are **not** hardcoded in the repo. You must supply them before `terraform plan` / `terraform apply`.

### Option A: `terraform.tfvars` (recommended)

1. Copy the example file (it is safe to commit; real values stay local):

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:

   | Variable | Required | Notes |
   |----------|----------|--------|
   | `assume_role_arn` | Yes | IAM role ARN Cribl Search assumes for S3 access. |
   | `assume_role_external_id` | Yes | Must match the role trust policy; treat as a secret. |
   | `s3_investigation_bucket` | Yes | Bucket name only (first segment of dataset paths). |
   | `aws_region` | No | Defaults to `eu-central-1` if omitted. |

3. **`terraform.tfvars` is listed in `.gitignore`** so it is not committed. Do not add real secrets to the example file or to tracked `.tf` files.

### Option B: Environment variables

Terraform maps `TF_VAR_<name>` to root module variables (useful in CI):

```bash
export TF_VAR_assume_role_arn="arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
export TF_VAR_assume_role_external_id="your-external-id"
export TF_VAR_s3_investigation_bucket="your-bucket-name"
# optional:
export TF_VAR_aws_region="eu-central-1"
```

You can combine both: values in `terraform.tfvars` can be overridden by `TF_VAR_*` where set.

### Init terraform
```bash
terraform init
```

## Deploy
```bash
terraform apply -auto-approve
```

## Destroy 
```bash
terraform destroy -auto-approve
```


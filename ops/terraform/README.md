# Terraform

## Usage
```
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
export AWS_DEFAULT_REGION=ap-northeast-1

terraform remote config -backend=s3 -backend-config="bucket=exampleapp-ops" -backend-config="key=production.tfstate"
```

```
export TF_VAR_aws_access_key=xxx
export TF_VAR_aws_secret_key=xxx
export TF_VAR_key_pair_public_key=xxx

terraform plan
terraform apply
```

# terraform-golden-modules
```bash
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json

conftest test tfplan.json --policy policy-repo/
```
## Debug command
```bash
jq '.resource_changes[] | select(.type=="aws_s3_bucket_public_access_block")' tfplan.json
```

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
## Issues
```bash
 conftest test tfplan.json --policy ./policies/s3

0 tests, 0 passed, 0 warnings, 0 failures, 0 exceptions
```
fix:
```bash
conftest test tfplan.json --policy ./policies/s3 --namespace s3.security

# o/p:
FAIL - tfplan.json - s3.security - block_public_acls must be true
FAIL - tfplan.json - s3.security - block_public_policy must be true
FAIL - tfplan.json - s3.security - ignore_public_acls must be true
FAIL - tfplan.json - s3.security - restrict_public_buckets must be true
```
By default conftest looks for the main namespace, so explicitly passing yours is worth trying.
### To pass all the namespaces
```bash
conftest test tfplan.json --policy ./policies/s3 --all-namespaces
# or
conftest test tfplan.json --policy ./policies \
  --namespace s3.security \
  --namespace ec2.security \
  --namespace iam.security
# or Rename your package to main so you don't need --namespace at all:
package main  # conftest uses this by default
```


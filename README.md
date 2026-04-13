# terraform-golden-modules
```bash
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json

conftest test tfplan.json --policy policy-repo/
```
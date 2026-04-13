# terraform-golden-modules
## OPA Installation
```bash
curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64
chmod +x opa
sudo mv opa /usr/local/bin/
```
## Conftest Installation
```bash
LATEST_VERSION=$(wget -O - "https://api.github.com/repos/open-policy-agent/conftest/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-)
ARCH=$(arch)
SYSTEM=$(uname)
wget "https://github.com/open-policy-agent/conftest/releases/download/v${LATEST_VERSION}/conftest_${LATEST_VERSION}_${SYSTEM}_${ARCH}.tar.gz"
tar xzf conftest_${LATEST_VERSION}_${SYSTEM}_${ARCH}.tar.gz
sudo mv conftest /usr/local/bin
```
## Test
```bash
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json

conftest test tfplan.json --policy policy-repo/
```
```bash
package main

deny contains msg if {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"

  after := resource.change.after
  after.acl == "public-read"

  msg := sprintf("S3 bucket %s is public", [resource.address])
}
```
```bash
conftest test tfplan.json --policy policies/s3_v3.rego
```
output:
```bash
1 test, 1 passed, 0 warnings, 0 failures, 0 exceptions
```

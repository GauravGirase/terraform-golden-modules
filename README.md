# terraform-golden-modules
## OPA Installation
```bash
curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64
chmod +x opa
sudo mv opa /usr/local/bin/
```
## Conftest Installation
```bash
curl -L -o conftest.tar.gz https://github.com/open-policy-agent/conftest/releases/latest/download/conftest_linux_amd64.tar.gz

tar -xzf conftest.tar.gz
sudo mv conftest /usr/local/bin/
```
## Test
```bash
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json

conftest test tfplan.json --policy policy-repo/
```
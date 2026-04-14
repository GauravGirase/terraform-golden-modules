FROM jenkins/jenkins:2.541.2-jdk21

USER root

# Install base dependencies + Docker CLI
RUN apt-get update && apt-get install -y \
    lsb-release ca-certificates curl unzip gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Terraform
ARG TERRAFORM_VERSION=1.10.5
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip && \
    terraform version

# Install OPA
ARG OPA_VERSION=1.15.0
RUN curl -fsSL https://github.com/open-policy-agent/opa/releases/download/v${OPA_VERSION}/opa_linux_amd64_static \
    -o /usr/local/bin/opa && \
    chmod +x /usr/local/bin/opa && \
    opa version

# Install Conftest
ARG CONFTEST_VERSION=0.57.0
RUN curl -fsSL https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz \
    -o /tmp/conftest.tar.gz && \
    tar -xzf /tmp/conftest.tar.gz -C /usr/local/bin conftest && \
    rm /tmp/conftest.tar.gz && \
    conftest --version

USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"

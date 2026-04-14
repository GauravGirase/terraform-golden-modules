pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = 'us-east-1'
        TF_IN_AUTOMATION = "true"
        POLICY_DIR = "policies/s3"
    }

    stages {
        
        stage('Verify AWS') {
            steps {
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Checkout Terraform Repo') {
            steps {
                git branch: 'app-infra',
                        url: 'https://github.com/GauravGirase/terraform-golden-modules.git'
            }
        }

        stage('Checkout OPA Policy Repo') {
            steps {
                dir("${POLICY_DIR}") {
                    git branch: 'main',
                        url: 'https://github.com/GauravGirase/terraform-golden-modules.git'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan.binary'
            }
        }

        stage('Convert Plan to JSON') {
            steps {
                sh 'terraform show -json tfplan.binary > tfplan.json'
            }
        }

        stage('OPA Policy Check') {
            steps {
                script {
                    sh """
                      conftest test tfplan.json --policy ./policies/s3 --all-namespaces
                    """

                    def violations = sh(
                        script: "jq '.result[0].expressions[0].value | length' opa_result.json",
                        returnStdout: true
                    ).trim()

                    if (violations != "0") {
                        error "OPA policy violations found!"
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                githubNotify context: 'OPA Policy Check', status: 'SUCCESS'
            }
        }
        failure {
            script {
                githubNotify context: 'OPA Policy Check', status: 'FAILURE'
            }
        }
    }
}

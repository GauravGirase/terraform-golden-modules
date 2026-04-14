pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
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
                      opa eval \
                      --format=json \
                      --data policy \
                      --input tfplan.json \
                      "data.terraform.deny" > opa_result.json
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

pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
        OPA_POLICY_DIR = "policy"   // directory where rego files exist
    }

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
                    def result = sh(
                        script: """
                        opa eval \
                          --format=json \
                          --data ${OPA_POLICY_DIR} \
                          --input tfplan.json \
                          "data.terraform.deny" > opa_result.json
                        """,
                        returnStatus: true
                    )

                    // Read OPA output
                    def opaOutput = readFile('opa_result.json')
                    echo "OPA Output: ${opaOutput}"

                    // Fail build if deny rules triggered
                    def violations = sh(
                        script: "cat opa_result.json | jq '.result[0].expressions[0].value | length'",
                        returnStdout: true
                    ).trim()

                    if (violations != "0") {
                        error "OPA policy violations found! Failing the build."
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ OPA checks passed. PR can be merged."
        }
        failure {
            echo "❌ OPA checks failed. PR merge should be blocked."
        }
    }
}

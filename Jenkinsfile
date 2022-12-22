pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        BACKEND_PATH = './env/backend.hcl'
    }
    stages {
        stage('Git checkout and AWS config') {
            steps {
                script {
                    if ($env.BRANCH_NAME == 'master') {
                        PATH = './env/prod.tfvars'
                        WORKSPACE = 'prod' }
                    if ($env.BRANCH_NAME == 'dev') {
                        PATH = './env/dev.tfvars'
                        WORKSPACE = 'dev' }
                }
                git branch: '${env.BRANCH_NAME}', credentialsId: 'Github', url: 'https://github.com/accenture-interns2022/dominos-v2.git'
                sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID && aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY && aws configure set region eu-central-1'
            }
        }
        stage('terraform format check') {
            steps {
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps {
                sh 'terraform init -backend-config=$BACKEND_PATH'
                sh 'terraform workspace select $WORKSPACE'
            }
        }
        stage('terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('terraform Plan') {
            steps {
                sh 'terraform plan -var-file=$PATH'
            }
        }
        stage('terraform apply') {
            steps {
                sh 'terraform apply --auto-approve -var-file=$PATH'
            }
            post {
                success {
                    echo 'Hello from Artur, Alex and Ilya to Ilyasov Sabir! Terraform apply was successful.'
                }
            }
        }
    }
}

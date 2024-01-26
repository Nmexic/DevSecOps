pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'myapp:latest'
        REGISTRY_URL = 'myregistry.com'
        REGISTRY_CREDENTIALS_ID = 'my-registry-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Nmexic/DevSecOps'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                    docker.withRegistry("https://${REGISTRY_URL}", "${REGISTRY_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        stage('Security Scan') {
            steps {
                // Buraya güvenlik taraması için komutlar eklenebilir
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Kubernetes'e dağıtım komutları
            }
        }
    }
}

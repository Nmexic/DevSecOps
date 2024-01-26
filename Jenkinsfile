pipeline {
    agent any

    environment {
        // Docker ve Registry konfigürasyonları
        DOCKER_IMAGE = 'myregistry.com/myapp:latest'
        REGISTRY_URL = 'docker.io'
        REGISTRY_CREDENTIALS_ID = 'snyk'

        // Kubernetes konfigürasyonları
        KUBE_CONFIG = '/Users/Mehmet/.kube/config'
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
                script {
                    // Snyk plugin kullanarak güvenlik taraması yap
                    snyk security: 'snyk', organisation: 'Nmexic', project: 'DevSecOps', targetFile: 'package.json'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Kubernetes manifest dosyalarını uygula
                    sh 'kubectl --kubeconfig ${KUBE_CONFIG} apply -f k8s/deployment.yaml'
                    sh 'kubectl --kubeconfig ${KUBE_CONFIG} apply -f k8s/service.yaml'
                }
            }
        }
    }
}

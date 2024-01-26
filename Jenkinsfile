pipeline {
    agent any

    environment {
        // Docker ve Registry konfigürasyonları
        DOCKER_IMAGE = 'myregistry.com/myapp:latest'
        REGISTRY_URL = 'docker.io'
        REGISTRY_CREDENTIALS_ID = 'docker'

        // Kubernetes konfigürasyonları
        KUBE_CONFIG = 'C:\\Users\\Mehmet\\.kube\\config'
    }

    stages {
        stage('Build and Test') {
            steps {
                bat 'npm install'
                bat 'npm test'
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    // Docker ve Registry konfigürasyonları burada yapılacak
                    // Örneğin: docker commands
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    // Snyk plugin kullanarak güvenlik taraması yap
                    // Örneğin: Snyk commands
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Kubernetes manifest dosyalarını uygula
                    bat 'kubectl --kubeconfig %KUBE_CONFIG% apply -f k8s\\deployment.yaml'
                    bat 'kubectl --kubeconfig %KUBE_CONFIG% apply -f k8s\\service.yaml'
                }
            }
        }
    }
}

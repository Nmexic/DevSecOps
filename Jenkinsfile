pipeline {
    agent any

    environment {
        // Docker ve Registry konfigürasyonları
        DOCKER_IMAGE = 'nmexic/devsecops:latest'
        REGISTRY_URL = 'docker.io'

        // Kubernetes konfigürasyonları
        KUBE_CONFIG_ID = 'kube-config' // Use Jenkins credential ID for kubeconfig
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
                    docker.withRegistry("https://${REGISTRY_URL}", 'docker') {
                        bat "docker build -t ${DOCKER_IMAGE} ."
                        bat "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Security Scan') {
            steps {
                bat "snyk test --all-projects"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBE_CONFIG_ID, variable: 'KUBECONFIG')]) {
                    bat "kubectl apply -f k8s\\deployment.yaml"
                    bat "kubectl apply -f k8s\\service.yaml"
                }
            }
        }
    }
}

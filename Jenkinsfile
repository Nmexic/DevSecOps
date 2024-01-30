pipeline {
    agent any

    environment {
        // Docker ve Registry konfigürasyonları
        DOCKER_IMAGE = 'nmexic/devsecops:latest'
        REGISTRY_URL = 'docker.io'
        REGISTRY_CREDENTIALS_ID = 'docker'

        // Kubernetes konfigürasyonları
        KUBE_CONFIG = 'C:\\Users\\Mehmet\\.kube\\config'
    }

    stages {
        // Checkout aşaması otomatik olarak gerçekleşeceği için burada belirtmeye gerek yok

        stage('Build and Test') {
            steps {
                bat 'npm install'
                bat 'npm test'
            }
        }

        stage('Docker Build and Push') {
            steps {
                bat "docker build -t ${DOCKER_IMAGE} ."
                bat "docker login -u ${REGISTRY_CREDENTIALS_ID} -p your-password ${REGISTRY_URL}"
                bat "docker push ${DOCKER_IMAGE}"
            }
        }

        stage('Security Scan') {
            steps {
                // Snyk CLI kurulu olduğu ve path'te olduğu varsayılarak
                bat "snyk test --all-projects"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat "kubectl --kubeconfig ${KUBE_CONFIG} apply -f k8s\\deployment.yaml"
                bat "kubectl --kubeconfig ${KUBE_CONFIG} apply -f k8s\\service.yaml"
            }
        }
    }
}

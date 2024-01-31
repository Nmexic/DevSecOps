pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nmexic/devsecops:latest'
        REGISTRY_URL = 'https://index.docker.io/v1/'
        REGISTRY_CREDENTIALS_ID = 'docker' 
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
                bat "docker build -t ${env.DOCKER_IMAGE} ."
                bat "docker login -u DOCKER_USERNAME -p DOCKER_PASSWORD ${env.REGISTRY_URL}"
                bat "docker push ${env.DOCKER_IMAGE}"
            }
        }

        stage('Security Scan') {
            steps {
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

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
                script {
                withCredentials([usernamePassword(credentialsId: 'your-docker-credentials-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin https://index.docker.io/v1/'
                    docker.withRegistry(REGISTRY_URL, REGISTRY_CREDENTIALS_ID) {
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
                bat "kubectl --kubeconfig ${KUBE_CONFIG} apply -f k8s\\deployment.yaml"
                bat "kubectl --kubeconfig ${KUBE_CONFIG} apply -f k8s\\service.yaml"
            }
        }
    }
}

pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nmexic/devsecops:latest'
        REGISTRY_URL = 'https://registry-1.docker.io/v2/'
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
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                    bat "echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USER% --password-stdin"
                    //bat "docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}"
                    bat "docker build -t ${env.DOCKER_IMAGE} ."
                    bat "docker push ${env.DOCKER_IMAGE}"
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

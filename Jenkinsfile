pipeline {
    agent any

    // (environment ve diğer konfigürasyonlar)

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
                echo 'Güvenlik taraması adımları buraya eklenecek'
                // Örnek: sh 'snyk test --all-projects'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Kubernetes dağıtım adımları buraya eklenecek'
                // Örnek: sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }
}

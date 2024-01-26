pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Nmexic/DevSecOps'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('Docker Build and Push') {
            steps {
                sh 'docker build -t myapp .'
                sh 'docker push myapp:latest'
            }
        }

        // Diğer adımlar buraya eklenebilir...
    }
}

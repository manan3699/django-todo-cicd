pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manan3699/django-todo-cicd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t chatbot-app:latest .'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker stop chatbot || true
                docker rm chatbot || true
                docker run -d --name chatbot -p 8001:8000 chatbot-app:latest
                '''
            }
        }
    }
}

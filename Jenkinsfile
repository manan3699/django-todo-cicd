pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/manan3699/django-todo-cicd', branch: 'main'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t chatbot-app:latest .'
            }
        }

        stage('Deploy') {
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

pipeline {
    agent any
    environment {
        IMAGE_NAME = "chatbot-app:latest"
        CONTAINER_NAME = "chatbot-container"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/manan3699/django-todo-cicd.git', credentialsId: 'github-credentials'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat "docker build --no-cache -t %IMAGE_NAME% ."
            }
        }
        stage('Stop Old Container') {
            steps {
                bat "docker stop %CONTAINER_NAME% || exit 0"
                bat "docker rm %CONTAINER_NAME% || exit 0"
            }
        }
        stage('Run Container') {
            steps {
                bat "docker run -d -p 8000:8000 --name %CONTAINER_NAME% %IMAGE_NAME%"
            }
        }
    }
}

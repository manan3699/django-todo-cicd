pipeline {
    agent any

    environment {
        IMAGE_NAME = "chatbot-app"
        CONTAINER_NAME = "chatbot-container"
    }

    stages {

        stage('Force Clean Workspace') {
            steps {
                sh '''
                rm -rf *
                '''
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manan3699/YOUR_CHATBOT_REPO.git'
            }
        }

        stage('Build NEW Docker Image') {
            steps {
                sh '''
                docker build --no-cache -t chatbot-app .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker stop chatbot-container || true
                docker rm chatbot-container || true
                '''
            }
        }

        stage('Run Chatbot') {
            steps {
                sh '''
                docker run -d \
                -p 8000:8000 \
                --name chatbot-container \
                chatbot-app
                '''
            }
        }
    }
}

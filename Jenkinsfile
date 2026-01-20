pipeline {
    agent any

    environment {
        IMAGE_NAME = "chatbot-app:v1"
        CONTAINER_NAME = "chatbot-container"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Latest Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manan3699/django-todo-cicd.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Force Docker Cleanup') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                docker rmi -f $IMAGE_NAME || true
                docker builder prune -af
                '''
            }
        }

        stage('Build NEW Chatbot Image') {
            steps {
                sh '''
                docker build --no-cache -t $IMAGE_NAME .
                '''
            }
        }

        stage('Run NEW Chatbot Container') {
            steps {
                sh '''
                docker run -d \
                -p 8000:8000 \
                --name $CONTAINER_NAME \
                $IMAGE_NAME
                '''
            }
        }
    }
}

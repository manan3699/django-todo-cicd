pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manan3699/chatbot"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manan3699/django-todo-cicd.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker stop chatbot || true
                docker rm chatbot || true
                docker run -d -p 8000:8000 --name chatbot $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}

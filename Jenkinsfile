pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manan3699/django-todo"
    }

    triggers {
        githubPush()
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manan3699/django-todo-cicd.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:latest ."
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker stop myapp || true
                docker rm myapp || true
                docker run -d -p 8000:8000 --name myapp ${DOCKER_IMAGE}:latest
                '''
            }
        }
    }
}

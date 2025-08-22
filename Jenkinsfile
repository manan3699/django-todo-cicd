pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manan3699/django-todo"
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
                    docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${BUILD_NUMBER}").push()
                        docker.image("${DOCKER_IMAGE}:${BUILD_NUMBER}").push("latest")
                    }
                }
            }
        }
    }
}
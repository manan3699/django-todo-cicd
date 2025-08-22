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
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if running
                    sh 'docker stop myapp || true && docker rm myapp || true'

                    // Run with correct port mapping
                    sh 'docker run -d -p 8000:8000 --name myapp ${DOCKER_IMAGE}:latest'
                }
            }
        }
    }
}

pipeline {
    agent any

    environment {
        IMAGE_NAME = "manan3699/jenkins/jenkins"   // change if needed
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',            // replace with 'master' if needed
                    url: 'https://github.com/manan3699/django-todo-cicd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                  docker rm -f $IMAGE_NAME || true
                  docker run -d -p 8000:8000 --name $IMAGE_NAME $IMAGE_NAME:latest
                '''
            }
        }
    }
}

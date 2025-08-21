pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/manan3699/django-todo-cicd.git',
                    credentialsId: 'dockerhub-creds'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t manan3699/jenkins/jenkins:latest .'
            }
        }
    }
}
 s
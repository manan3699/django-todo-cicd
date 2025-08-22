pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manan3699/django-todo"
        // 🔹 CHANGE THIS → your DockerHub username
        DOCKERHUB_USER = "manan3699"

        // 🔹 You can keep this name or change (will be the Docker image name)
        IMAGE_NAME = "jenkins/jenkins"

        // 🔹 Tag for the Docker image
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/manan3699/django-todo-cicd.git',
                    credentialsId: 'github-credentials'
                    // 🔹 CHANGE THIS → put your GitHub repo URL
                    url: 'https://github.com/manan3699/django-todo-cicd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
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
                sh 'docker build -t $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker rm -f django-todo-container || true
                    docker run -d -p 8000:8000 --name django-todo-container $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }
}
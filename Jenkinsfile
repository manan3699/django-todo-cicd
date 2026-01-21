pipeline {
    agent any

    environment {
        IMAGE_NAME = "manan3699/chatbot-app"
        IMAGE_TAG  = "latest"
        OPENAI_API_KEY = credentials('openai-api-key')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/<https://github.com/manan3699/django-todo-cicd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile.chatbot .
                '''
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                sh '''
                docker push $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Deploy to GCP VM') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no parmarrahul2102@34.42.50.173 << EOF
                        docker pull $IMAGE_NAME:$IMAGE_TAG
                        docker stop chatbot-app || true
                        docker rm chatbot-app || true
                        docker run -d \
                          --name chatbot-app \
                          -p 8000:5000 \
                          -e OPENAI_API_KEY=$OPENAI_API_KEY \
                          $IMAGE_NAME:$IMAGE_TAG
                    EOF
                    '''
                }
            }
        }
    }
}

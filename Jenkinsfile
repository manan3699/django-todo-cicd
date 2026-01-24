pipeline {
    agent any

    environment {
        IMAGE_NAME = "manan3699/chatbot-app"
        IMAGE_TAG  = "latest"
        CONTAINER_NAME = "chatbot-prod"
        VM_IP = "34.42.50.173"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main',
                    url: 'git@github.com:manan3699/chatbot-app.git',
                    credentialsId: 'github-ssh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Deploy to GCP VM') {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'gcp-ssh',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    ),
                    string(
                        credentialsId: 'openai-api-key',
                        variable: 'OPENAI_API_KEY'
                    )
                ]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i \$SSH_KEY \$SSH_USER@\$VM_IP << EOF
                        docker pull $IMAGE_NAME:$IMAGE_TAG
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                        docker run -d \\
                          --name $CONTAINER_NAME \\
                          -p 8000:5000 \\
                          -e OPENAI_API_KEY=\$OPENAI_API_KEY \\
                          $IMAGE_NAME:$IMAGE_TAG
                    EOF
                    """
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check logs above."
        }
        success {
            echo "✅ Deployment successful! Chatbot is live."
        }
    }
}

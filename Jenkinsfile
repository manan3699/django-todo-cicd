pipeline {
    agent any

    environment {
        IMAGE_NAME = "manan3699/django-todo"
        IMAGE_TAG  = "latest"
        CONTAINER_NAME = "django-todo-prod"
        VM_IP = "34.42.50.173"
    }

   stage('Clone Repo') {
    steps {
        deleteDir()   // 🔥 THIS IS THE KEY
        git credentialsId: 'github-ssh',
            url: 'git@github.com:manan3699/django-todo-cicd.git',
            branch: 'main'
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
                    )
                ]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i \$SSH_KEY \$SSH_USER@\$VM_IP "
                        docker pull $IMAGE_NAME:$IMAGE_TAG &&
                        docker stop $CONTAINER_NAME || true &&
                        docker rm $CONTAINER_NAME || true &&
                        docker run -d \
                          --name $CONTAINER_NAME \
                          -p 8000:8000 \
                          $IMAGE_NAME:$IMAGE_TAG
                    "
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ CI/CD pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs above."
        }
    }
}

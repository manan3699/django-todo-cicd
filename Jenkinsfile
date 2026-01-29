pipeline {
    agent any

    environment {
        IMAGE_NAME = "manan3699/django-todo"
        TAG = "latest"
        VM_USER = "manan"
        VM_IP = "34.42.50.173"
    }

    stages {

        stage('Clone Repo') {
            steps {
                deleteDir()   // 🔥 prevents git corruption after restart
                git credentialsId: 'github-ssh',
                    url: 'git@github.com:manan3699/django-todo-cicd.git',
                    branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${TAG} ."
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                    sh """
                    echo \$DOCKER_PASS | docker login -u manan3699 --password-stdin
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push ${IMAGE_NAME}:${TAG}"
            }
        }

        stage('Deploy to GCP VM') {
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'gcp-ssh',
                    keyFileVariable: 'SSH_KEY'
                )]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i \$SSH_KEY ${VM_USER}@${VM_IP} '
                        docker pull ${IMAGE_NAME}:${TAG} &&
                        docker stop django-todo-prod || true &&
                        docker rm django-todo-prod || true &&
                        docker run -d \
                          --name django-todo-prod \
                          -p 8000:8000 \
                          ${IMAGE_NAME}:${TAG}
                    '
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
            echo "❌ CI/CD pipeline failed. Check logs."
        }
    }
}

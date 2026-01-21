FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

# Allow Jenkins user to run docker
RUN usermod -aG docker jenkins

USER jenkins

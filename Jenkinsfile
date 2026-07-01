pipeline {
    agent any

    environment {
        IMAGE_NAME = "devangkurade/devops-app"

        DOCKER_USER = credentials('8df9a7ba-3a55-4ca2-87f3-4c89c2f9dbe4')
        DOCKER_PASS = credentials('8df9a7ba-3a55-4ca2-87f3-4c89c2f9dbe4')

        EC2_HOST = "ubuntu@16.16.25.253"
        CONTAINER_NAME = "static-website"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Login & Push Image') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
            sh '''
            echo $PASS | docker login -u $USER --password-stdin
            docker push devangkurade/devops-app:latest
            '''
        }
    }

        stage('Deploy on EC2') {
    steps {
        sshagent(['4d8d34ba-031b-4071-9ee7-b97768931427']) {
            sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@16.16.25.253 "
                docker stop static-website || true &&
                docker rm static-website || true &&
                docker pull devangkurade/devops-app:latest &&
                docker run -d -p 80:80 --name static-website devangkurade/devops-app:latest
            "
            '''
        }
    }
}

    }
}

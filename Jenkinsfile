pipeline {
    agent any

    environment {
        IMAGE_NAME = "devangkurade/devops-app"

        DOCKER_USER = credentials('docker-hub')
        DOCKER_PASS = credentials('docker-hub')

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
        }
    stage('Deploy on EC2') {
    steps {
        sh '''
        ssh -i /home/ubuntu/test-key.pem -o StrictHostKeyChecking=no ubuntu@16.16.25.253 "
            docker stop static-website || true &&
            docker rm static-website || true &&
            docker pull devangkurade/devops-app:latest &&
            docker run -d --name static-website -p 80:80 devangkurade/devops-app:latest
        "
        '''
    }
}

    }
}

pipeline {
    agent any

    environment {
        IMAGE_NAME = "static-website"
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

        stage('Remove Old Container') {
            steps {
                sh 'docker rm -f $CONTAINER_NAME || true'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d \
                --name $CONTAINER_NAME \
                -p 8085:80 \
                $IMAGE_NAME:latest
                '''
            }
        }
        stage('Deploy') {
    steps {
        sh """
        scp -r dist/* ubuntu@<EC2-IP>:/var/www/html/
        """
    }
}
    }
}

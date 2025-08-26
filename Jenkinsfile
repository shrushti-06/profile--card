pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-profile-card"
        CONTAINER_NAME = "myprofile"
        PORT = "8081"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/shrushti-06/profile--card.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    sh """
                    if [ \$(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                        docker stop ${CONTAINER_NAME}
                        docker rm ${CONTAINER_NAME}
                    fi
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh "docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed! Access your profile at http://localhost:${PORT}"
        }
        failure {
            echo "Pipeline failed. Check the logs."
        }
    }
}

pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-profile-card"
        CONTAINER_NAME = "myprofile"
        PORT = "8081"
        GIT_CREDENTIALS_ID = "github-token"  // Your GitHub credentials ID in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from GitHub..."
                git url: 'https://github.com/shrushti-06/profile--card.git',
                    branch: 'main',
                    credentialsId: "${GIT_CREDENTIALS_ID}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh '''
                        if ! command -v docker &> /dev/null; then
                            echo "Docker is not installed or not available!"
                            exit 1
                        fi
                        docker build -t ${IMAGE_NAME} .
                    '''
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    echo "Stopping old container if it exists..."
                    sh '''
                        if [ $(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                            docker stop ${CONTAINER_NAME}
                            docker rm ${CONTAINER_NAME}
                        fi
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo "Running new container..."
                    sh "docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! Access your profile at http://localhost:${PORT}"
        }
        failure {
            echo "Pipeline failed. Check the Jenkins logs for details."
        }
    }
}

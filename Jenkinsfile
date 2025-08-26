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
                echo "Building Docker image..."
                powershell """
                    if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
                        Write-Host 'Docker is not installed or not available!'
                        exit 1
                    }

                    docker build -t \$env:IMAGE_NAME .
                """
            }
        }

        stage('Stop Old Container') {
            steps {
                echo "Stopping old container if it exists..."
                powershell """
                    \$container = docker ps -a --filter "name=\$env:CONTAINER_NAME" --format "{{.Names}}"
                    if (\$container) {
                        docker stop \$env:CONTAINER_NAME
                        docker rm \$env:CONTAINER_NAME
                    } else {
                        Write-Host "No container named \$env:CONTAINER_NAME found."
                    }
                """
            }
        }

        stage('Run Container') {
            steps {
                echo "Running new container..."
                powershell """
                    docker run -d -p \$env:PORT:80 --name \$env:CONTAINER_NAME \$env:IMAGE_NAME
                """
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

pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'drv4ever/abc-tech-website:latest'
        REPO_URL = 'https://github.com/Drv4ever/24BIT0379_DhruvJain_DevOps-Project.git'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '=== STAGE: Checkout ==='
                echo "Fetching code from repository: ${env.REPO_URL} (main branch)"
                git branch: 'main', url: "${env.REPO_URL}"
            }
        }

        stage('Build') {
            steps {
                echo '=== STAGE: Build ==='
                echo "Building Docker image: ${env.DOCKER_IMAGE}"
                sh "docker build -t ${env.DOCKER_IMAGE} ."

                // Note: To push the image to Docker Hub, configure credentials in Jenkins and uncomment below:
                // withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                //     sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USER --password-stdin"
                //     sh "docker push ${env.DOCKER_IMAGE}"
                // }
            }
        }

        stage('Deploy') {
            steps {
                echo '=== STAGE: Deploy ==='
                echo 'Applying Kubernetes manifests using kubectl...'
                sh "kubectl apply -f k8s-deployment.yaml"
                echo 'Checking deployment status...'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please inspect build console outputs.'
        }
    }
}

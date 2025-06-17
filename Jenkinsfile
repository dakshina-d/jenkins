pipeline {
    agent any

    tools {
        maven 'Maven 3.8.1'      // Make sure this matches the Maven version you configured in Jenkins
        jdk 'JDK 17'             // Also match this with what you configured in Jenkins tools
    }

    environment {
        IMAGE_NAME = 'my-java-app'
        CONTAINER_NAME = 'my-java-app'
        APP_PORT = '8085'        // Make sure your Spring Boot app is configured to run on this port
    }

    triggers {
        pollSCM('H/2 * * * *')   // Poll GitHub every 2 minutes for changes
    }

    stages {
        stage('Clone from GitHub') {
            steps {
                git credentialsId: 'github-creds', url: 'https://github.com/dakshina-d/jenkins.git', branch: 'main'
            }
        }

        stage('Build with Maven') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('Remove Previous Container') {
            steps {
                bat '''
                docker stop %CONTAINER_NAME% || echo No running container to stop
                docker rm %CONTAINER_NAME% || echo No container to remove
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                bat "docker run -d --name %CONTAINER_NAME% -p %APP_PORT%:%APP_PORT% %IMAGE_NAME%"
            }
        }
    }

    post {
        success {
            echo '🎉 Build and deployment completed successfully.'
        }
        failure {
            echo '❌ Build or deployment failed.'
        }
    }
}

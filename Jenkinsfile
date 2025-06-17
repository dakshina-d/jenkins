pipeline {
    agent any

    tools {
        maven 'Maven 3.8.1'
        jdk 'JDK 17'
    }

    environment {
        IMAGE_NAME = 'my-java-app'
    }

    stages {
        stage('Clone from GitHub') {
            steps {
                git credentialsId: 'github-creds', url: 'https://github.com/dakshina-d/jenkins.git'
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

        stage('Run Container') {
            steps {
                bat "docker run -d -p 8085:8085 %IMAGE_NAME%"
            }
        }
    }
}

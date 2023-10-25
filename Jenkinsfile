pipeline {
    agent any
    
    environment {
        // Встановлюємо змінні середовища
        SONARQUBE_URL = 'http://localhost:9000'
        DOCKER_REPO = 'my-docker-repo'
        DOCKER_IMAGE_NAME = 'my-docker-image'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонуємо репозиторій
                checkout scm
            }
        }

        stage('SonarQube Scan') {
            steps {
                //name from jenkins
                withCredentials([string(credentialsId: 'sonarqube-credentials', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('My_Sonar') {
                        sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Будуємо Docker образ
                script {
                    docker.build("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Tag and Push Docker Image') {
            steps {
                // Тегуємо та пушимо Docker образ
                script {
                    docker.withRegistry("${env.DOCKER_REPO}", 'docker-credentials') {
                        docker.image("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        docker.image("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push('latest')
                    }
                }
            }
        }
    }
}
}
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
                withSonarQubeEnv('My_Sonar') {
                    // Запускаємо аналіз коду на SonarQube
                    sh "${tool('My_Sonar')}/bin/sonar-scanner"
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

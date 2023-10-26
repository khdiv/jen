pipeline {
    agent any
    
    environment {
        DOCKER_REPO = 'my-docker-repo'
        DOCKER_IMAGE_NAME = 'my-docker-image'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // Uncomment this section if you want to use SonarQube
        // stage('SonarQube Scan') {
        //     steps {
        //         withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
        //             withSonarQubeEnv('My_Sonar') {
        //                 sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN'
        //             }
        //         }
        //     }
        // }

    stage('Build Docker Image') {
        steps {
            script {
                    // Build Docker image
                sh "docker build -t ${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ."
            }
        }
    }

    stage('Push Docker Image') {
        steps {
            script {
                    // Push Docker image
                sh "docker push ${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
            }
        }
    
}
}


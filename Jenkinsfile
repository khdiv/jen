pipeline {
    agent any
    environment {
        DOCKER_REPO = 'khdiv/jenkins-images'
        DOCKER_TAG = '0.4'
        //SONAR_RUNNER_HOME = '/opt/sonar-scanner'
    }

    stages {
        stage('Docker version') {
            steps {
                sh "echo $USER"
                sh 'docker version'
            }
        }

        stage('Test') {
            steps {
                dir('docker-push') {
                    sh "ls -la "
                    sh "pwd"
                }
                sh "ls -la "
                sh "pwd"
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'feature',
                    url: 'https://github.com/khdiv/jen.git'        
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('docker-push') {
                    // Assuming Dockerfile is in the same directory as Jenkinsfile
                    sh 'docker build -t khdiv/jenkins-images:0.4  -f /var/lib/jenkins/workspace/docker-push/Dockerfile .'
                }
            }
        }

        stage('Push docker image to DockerHub') {
            steps {
                withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
                    sh '''
                        docker push khdiv/jenkins-images:0.4
                    '''
                }
            }
        }
    }
}

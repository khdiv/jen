pipeline {
    agent any
    
    environment {
        DOCKER_REPO = 'khdiv/my-docker-repo'
        DOCKER_IMAGE_NAME = 'my-docker-image'
    }

    stages {
        // ... (your existing stages)

        stage('Tag Docker Image') {
            steps {
                script {
                    // Use the build number as the tag
                    def buildTag = "${env.BUILD_NUMBER}"

                    // Tag the image without specifying a tag (uses the latest tag)
                    docker.tag("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${buildTag}", "${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}")
                    
                    // Tag the image with a specific tag
                    docker.tag("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:${buildTag}", "${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:my-docker-image")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub') {
                        // Push the image with the latest tag
                        docker.image("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}").push()

                        // Push the image with a specific tag
                        docker.image("${env.DOCKER_REPO}/${env.DOCKER_IMAGE_NAME}:my-docker-image").push()
                    }
                }
            }
        }
    }
}

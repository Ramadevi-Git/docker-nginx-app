pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('Docker-cred')
        IMAGE_NAME = "ramakarthi/my-custom-image"
        CONTAINER_NAME = "my_app"
    }

    stages {

        stage('Build Image') {
            steps {
                sh '''
                    export DOCKER_BUILDKIT=0
                    docker build -t $IMAGE_NAME:$BUILD_NUMBER .
                '''
            }
        }

        stage('Docker Login') {
            steps {
                sh '''
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login \
                        -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true

                    docker run -d \
                        --name $CONTAINER_NAME \
                        -p 80:80 \
                        $IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }
    }
}

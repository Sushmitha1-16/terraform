pipeline {
  agent any

  environment {
    REPO_URL = 'https://github.com/betawins/Trading-UI.git'
    IMAGE_NAME = 'your-dockerhub-username/trading-ui:latest'
  }

  stages {

    stage('Checkout Code') {
      steps {
        git url: "${REPO_URL}", branch: 'main'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t $IMAGE_NAME .'
        }
      }
    }

    stage('Push to DockerHub') {
      when {
        expression { return params.PUSH_IMAGE }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          script {
            sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
            sh 'docker push $IMAGE_NAME'
            sh 'docker logout'
          }
        }
      }
    }

    stage('Deploy Container') {
      steps {
        script {
          sh '''
            docker rm -f trading-ui || true
            docker run -d --name trading-ui -p 3000:3000 $IMAGE_NAME
          '''
        }
      }
    }
  }

  parameters {
    booleanParam(name: 'PUSH_IMAGE', defaultValue: false, description: 'Push Docker image to DockerHub?')
  }
}

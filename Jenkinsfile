pipeline {
  agent { label 'slave01' }   // ton agent Windows

  environment {
    DOCKER_IMAGE = "docker.io/samaramri/hello-jenkins:${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Docker Login') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                          usernameVariable: 'DH_USER',
                                          passwordVariable: 'DH_PASS')]) {
          bat '''
          echo %DH_PASS% | docker login -u "%DH_USER%" --password-stdin
          '''
        }
      }
    }

    stage('Build Image') {
      steps {
        bat 'docker build -t "%DOCKER_IMAGE%" .'
      }
    }

    stage('Push Image') {
      steps {
        bat 'docker push "%DOCKER_IMAGE%"'
      }
    }
  }

  post {
    always { bat 'docker logout || exit /b 0' }
    success { echo "Pushed: ${env.DOCKER_IMAGE}" }
  }
}

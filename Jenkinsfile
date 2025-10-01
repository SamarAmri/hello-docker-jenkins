pipeline {
  agent { label 'slave01' }     // si ton agent s’appelle 'slave01' (sinon mets 'slave_build')

  environment {
    // <<< ICI: ton namespace Docker Hub + le nom d'image >>>
    DOCKER_IMAGE = "docker.io/samaramri/hello-jenkins:${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Docker Login') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
          sh '''
            echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
          '''
        }
      }
    }

    stage('Build Image') {
      steps { sh 'docker build -t "$DOCKER_IMAGE" .' }
    }

    stage('Push Image') {
      steps { sh 'docker push "$DOCKER_IMAGE"' }
    }
  }

  post {
    always { sh 'docker logout || true' }
    success { echo "Pushed: ${env.DOCKER_IMAGE}" }
  }
}

pipeline {
  agent { label 'slave_build' }    // ou 'slave01' si c'est le label que tu utilises
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
          sh '''
            echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
          '''
        }
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t "$DOCKER_IMAGE" .'
      }
    }

    stage('Push Image') {
      steps {
        sh 'docker push "$DOCKER_IMAGE"'
      }
    }
  }

  post {
    always {
      sh 'docker logout || true'
    }
    success { echo "Pushed: ${env.DOCKER_IMAGE}" }
  }
}

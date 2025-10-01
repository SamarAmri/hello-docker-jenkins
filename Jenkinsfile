pipeline {
  agent { label 'slave01' }    // on force l'exécution sur ton agent connecté

  environment {
    // <-- Ton image locale de l'atelier (vue dans ta capture "docker images")
    LOCAL_IMAGE   = "samar/alpine:1.0.0"

    // <-- Où on pousse : ton dépôt Docker Hub + un tag = numéro de build
    REMOTE_IMAGE  = "docker.io/TON_DOCKERHUB_USER/alpine:${env.BUILD_NUMBER}"
  }

  stages {
    stage('Docker Login') {
      steps {
        // Utilise le credential créé en atelier Docker (username + access token)
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
          sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
        }
      }
    }

    stage('Tag & Push Existing Image') {
      steps {
        sh '''
          # Tag l'image locale vers ton repo Docker Hub
          docker tag "$LOCAL_IMAGE" "$REMOTE_IMAGE"
          # Puis pousse-la
          docker push "$REMOTE_IMAGE"
        '''
      }
    }
  }

  post {
    always { sh 'docker logout || true' }
    success { echo "Pushed: ${env.REMOTE_IMAGE}" }
  }
}

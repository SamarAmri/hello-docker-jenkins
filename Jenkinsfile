pipeline {
  // Où exécuter ? sur ton agent connecté (tu as le label 'slave01' dans tes captures)
  agent { label 'slave01' }

  // Nom/Tag de l'image que l'on va construire et pousser
  environment {
    DOCKER_IMAGE = "docker.io/TON_DOCKERHUB_USERNAME/hello-jenkins:${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps {
        // 1) Récupère ce dépôt GitHub (le code et les fichiers)
        checkout scm
      }
    }

    stage('Docker Login') {
      steps {
        // 2) Se connecter à Docker Hub en utilisant le credential créé en atelier
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
          sh '''
            echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
          '''
        }
      }
    }

    stage('Build Image') {
      steps {
        // 3) Construire l'image Docker en lisant le Dockerfile du repo
        sh 'docker build -t "$DOCKER_IMAGE" .'
      }
    }

    stage('Push Image') {
      steps {
        // 4) Pousser l'image sur Docker Hub
        sh 'docker push "$DOCKER_IMAGE"'
      }
    }
  }

  post {
    // Toujours se déconnecter proprement
    always { sh 'docker logout || true' }
    success { echo "Pushed: ${env.DOCKER_IMAGE}" }
  }
}

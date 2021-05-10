pipeline {

  agent any

  triggers {
    issueCommentTrigger('.*build this please.*')
  }

  environment {
    SLACK_CHANNEL = '#opensource-cicd'
  }

  stages {

    stage ('Start') {
      steps {
        cancelPreviousBuilds()
        sendNotifications('STARTED', SLACK_CHANNEL)
      }
    }

    stage ('Running all tests') {
      steps {
        container('builder') {
          script {
            sh 'make test'
          }
        }
      }
    }

    stage ('Building and Pushing Gems') {
      environment {
        GEM_HOST_API_KEY = credentials('jenkins-rubygems-api-key')
      }
      when {
        buildingTag()
      }
      steps {
        container('builder') {
          script { 
            sh 'make gem.publish'
          }
        }
      }
    }
  }

  post {
    success {
      sendNotifications('SUCCESS', SLACK_CHANNEL)
    }
    failure {
      sendNotifications('FAILED', SLACK_CHANNEL)
    }
  }
}

pipeline {
    agent any
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
        disableConcurrentBuilds()
    }
    stages {
        stage ('Hello') {
            steps {
                echo "hello"
            }
        }
        stage('Feature or fix branch'){
            when {
                branch "fix-*"
            }
            steps {
                sh '''
                   cat README.md
                   '''
            }
        }
        stage('PR or Pull Request') {
            when {
                branch 'PR-*'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'bicepconnect', passwordVariable: 'AZURE_CLIENT_SECRET', usernameVariable: 'AZURE_CLIENT_ID')]) {
                    sh 'sh deploy.sh'
                }
            }
        }
    }
}
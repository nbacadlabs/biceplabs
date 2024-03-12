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
                   cat 'README.md'
                   '''
            }
        }
        stage('PR or Pull Request') {
            when {
                branch 'PR-*'
            }
            steps {
               withCredentials([azureServicePrincipal('bicepconnect')]) {
                sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                }
            }
        }
    }
}
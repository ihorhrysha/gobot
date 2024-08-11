pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick ARCH')
    }

    environment {
        GITHUB_REPOSITORY='https://github.com/ihorhrysha/gobot.git'
        REGISTRY = 'ghcr.io'
        REPOSITORY = 'ihorhrysha/gobot'
        GIT_BRANCH = 'master'
        GITHUB_TOKEN_ID = 'github'
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GITHUB_REPOSITORY}"
            }
        }

        stage('Test') {
            steps {
                sh "make test"
            }
        }

        stage('Login to Github Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: GITHUB_TOKEN_ID, usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')]) {
                    sh '''
                        echo $GITHUB_PASSWORD | docker login $REGISTRY -u $GITHUB_USERNAME --password-stdin
                    '''
                }
            }
        }
        
        stage('Release') {
            steps {
                sh "make release REGISTRY=$REGISTRY REPOSITORY=$REPOSITORY TARGETARCH=${params.ARCH} TARGETOS=${params.OS}"
            }
        } 

        stage('Clean') {
            steps {
                sh "make clean REGISTRY=$REGISTRY REPOSITORY=$REPOSITORY TARGETARCH=${params.ARCH} TARGETOS=${params.OS}"
            }
        } 
    }
}
pipeline {
    agent any

    tools {
        nodejs 'NodeJS_18' // Define in Jenkins: Manage Jenkins > Global Tool Configuration
    }

    environment {
        REPO_URL = 'https://github.com/betawins/Trading-UI.git'
        APP_PORT = '3000'
    }

    stages {

        stage('Checkout') {
            steps {
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Install npm prerequisites') {
    steps {
        sh 'npm audit fix || true'
    }
}


        stage('Run Tests') {
            steps {
                echo "Running tests..."
                sh 'npm test || echo "No tests found or some tests failed."'
            }
        }

        stage('Build') {
            steps {
                echo "Building the app..."
                sh 'npm run build'
            }
        }

        stage('Archive Build Artifacts') {
            steps {
                archiveArtifacts artifacts: 'dist/**', fingerprint: true
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                script {
                    echo "Building Docker image and running container..."
                    sh '''
                    docker stop trading-ui-container || true
                    docker rm trading-ui-container || true
                    docker build -t trading-ui:latest .
                    docker run -d -p ${APP_PORT}:${APP_PORT} --name trading-ui-container trading-ui:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}


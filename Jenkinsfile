// Jenkinsfile
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from SCM..."
                // When using "Pipeline script from SCM", Jenkins automatically checks out the code.
                // You generally don't need a `git clone` step here unless you need a specific configuration.
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests' // Example for a Maven project
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test' // Example for a Maven project
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package' // Example for a Maven project
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true // Archive build artifacts
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed. Check console output for errors.'
        }
    }
}

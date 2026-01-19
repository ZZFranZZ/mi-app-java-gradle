pipeline {
    agent { label 'self-hosted' }
    stages {
        stage('Commit Stage') {
            steps {
                sh 'chmod +x gradlew'
                sh './gradlew clean compileJava test'
            }
        }
        stage('Code Quality') {
            steps {
                sh './gradlew jacocoTestReport'
            }
        }
    }
}

pipeline {
    agent { label 'self-hosted' }
    
    stages {
        stage('Build & Test') { 
            steps {
                sh 'chmod +x gradlew'
                // Cambiamos a 'build' para que genere el archivo .jar en build/libs/
                sh './gradlew clean build' 
            }
        }
        
        stage('Code Quality') {
            steps {
                sh './gradlew jacocoTestReport'
            }
        }

        /* Próximo paso (comentado por ahora): 
        Aquí es donde usaremos el Dockerfile para crear la imagen
        y luego enviarla a tu cluster con kubectl.
        */
    }
}

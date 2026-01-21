pipeline {
    agent { label 'self-hosted' }
    
    stages {
        stage('Build & Test') { 
            steps {
                sh 'chmod +x gradlew'
                // Genera el .jar en build/libs/
                sh './gradlew clean build' 
            }
        }
        
        stage('Code Quality') {
            steps {
                sh './gradlew jacocoTestReport'
            }
        }

        stage('Docker Build') {
	    steps {
                script {
                    // 1. Verificamos que el JAR ya está en la raíz (gracias al cambio en build.gradle)
                    sh 'ls -lh app.jar'
                    
                    // 2. Construimos la imagen. 
                    // El Dockerfile solo necesita hacer 'COPY app.jar app.jar'
                    sh "docker build -t mi-app-java:latest -t mi-app-java:${env.BUILD_NUMBER} ."
                }
                echo "¡Imagen Docker construida y etiquetada exitosamente!"
            }
        }

        stage('K8s Deploy (Simulado)') {
            steps {
                // Como ya tienes kubectl montado, este comando funcionará
                // Por ahora solo verificamos que Jenkins vea el cluster
                sh 'kubectl get nodes'
                echo "Listo para aplicar el deployment.yaml en el siguiente paso."
            }
        }
    }
    
    post {
        success {
            echo "¡Pipeline finalizado con éxito! La imagen mi-app-java:latest está lista."
        }
        failure {
            echo "Algo falló. Revisa los logs de la consola."
        }
    }
}

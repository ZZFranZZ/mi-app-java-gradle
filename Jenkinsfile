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
                // Construye la imagen usando el Dockerfile de la raíz
                // Le ponemos un tag con el número de build para tener historial
                sh 'ls -R build/libs/'  // Esto nos chivará dónde está el JAR exacto
                sh 'find build/libs/ -name "*.jar"'
                sh 'docker build --build-arg JAR_FILE=$(ls build/libs/*.jar | grep -v plain | head -n 1) -t mi-app-java:latest .'
                echo "Imagen Docker construida exitosamente."
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

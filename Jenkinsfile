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
            steps {
                script {
                    echo "--- INICIANDO CONSTRUCCIÓN Y EMPAQUETADO ---"
                    
                    // 1. Corregimos permisos y compilamos en un solo paso
                    sh 'chmod +x gradlew'
                    sh './gradlew clean build'
                    
                    echo "--- BUSCANDO EL ARTEFACTO ---"
                    // 2. Buscamos el JAR y lo traemos a la raíz (usando doble barra \\ para que Groovy no se queje)
                    sh 'find . -name "*.jar" ! -name "*plain*" -exec cp {} app.jar \\;'
                    
                    // 3. Verificamos que el archivo está listo
                    sh 'ls -lh app.jar'
                    
                    // 4. Construimos la imagen Docker
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

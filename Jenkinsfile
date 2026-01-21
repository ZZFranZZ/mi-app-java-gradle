pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mi-app-java"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Docker') {
            steps {
                script {
                    echo "--- INICIANDO CONSTRUCCIÓN Y EMPAQUETADO ---"
                    
                    // 1. Corregimos permisos y compilamos
                    sh 'chmod +x gradlew'
                    sh './gradlew clean build'
                    
                    echo "--- BUSCANDO EL ARTEFACTO ---"
                    // 2. Buscamos el JAR y lo traemos a la raíz (usando doble barra \\)
                    sh 'find . -name "*.jar" ! -name "*plain*" -exec cp {} app.jar \\;'
                    
                    // 3. Verificamos que el archivo está listo
                    sh 'ls -lh app.jar'
                    
                    // 4. Construimos la imagen Docker
                    sh "docker build -t ${DOCKER_IMAGE}:latest -t ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('K8s Deploy (Simulado)') {
            steps {
                echo "Simulando despliegue en Kubernetes..."
                echo "Desplegando imagen: ${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
            }
        }
    }

    post {
        success {
            echo '¡Pipeline finalizado con éxito!'
        }
        failure {
            echo 'Algo falló. Revisa los logs de la consola.'
        }
    }
}

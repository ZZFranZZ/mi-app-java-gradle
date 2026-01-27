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

        stage('Build JAR') {
            steps {
                script {
                    echo "--- COMPILANDO PROYECTO SPRING BOOT ---"

                    sh 'chmod +x gradlew'
                    sh './gradlew clean bootJar'

                    echo "--- ARTEFACTOS EN build/libs ---"
                    sh 'ls -lh build/libs'
                }
            }
        }

        stage('Select Artifact') {
            steps {
                script {
                    echo "--- SELECCIONANDO EL JAR EJECUTABLE ---"

                    sh '''
                        JAR=$(ls build/libs/*-SNAPSHOT.jar 2>/dev/null || ls build/libs/*.jar | grep -v plain | head -n 1)

                        if [ -z "$JAR" ]; then
                          echo "ERROR: No se encontró un JAR ejecutable"
                          exit 1
                        fi

                        cp "$JAR" app.jar
                        echo "Artefacto seleccionado: $JAR"
                        ls -lh app.jar
                    '''
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "--- CONSTRUYENDO IMAGEN DOCKER ---"
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

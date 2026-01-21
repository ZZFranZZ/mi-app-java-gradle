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
		// 1. Buscamos el archivo JAR (excluyendo el 'plain') y lo copiamos a la raíz como app.jar
                // El comando 'find' busca en todas las subcarpetas.
            	sh 'find . -name "*.jar" ! -name "*plain*" -exec cp {} app.jar \;'
                // 2. Verificamos que el archivo existe (si esto falla, el log nos dirá por qué)
            	sh 'ls -lh app.jar'
                // 3. Construimos la imagen. Ya no necesitamos --build-arg porque el archivo se llama siempre app.jar
                sh "docker build -t mi-app-java:latest -t mi-app-java:${env.BUILD_NUMBER} ."
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

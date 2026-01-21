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
		// Buscamos el jar y lo movemos a la raíz de forma sencilla
                // Esto evita usar la barra invertida que rompió el pipeline
            	sh 'cp build/libs/*SNAPSHOT.jar app.jar || cp build/libs/*.jar app.jar || true'
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

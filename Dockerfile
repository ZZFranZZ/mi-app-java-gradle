FROM eclipse-temurin:17-jdk-alpine
# Copiamos el app.jar que el paso de Jenkins acaba de preparar en la raíz
COPY app.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

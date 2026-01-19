FROM openjdk:17-jdk-slim
# No usamos COPY build/libs/*.jar porque a veces hay dos archivos (el plain y el normal)
# Mejor especificamos el nombre si lo conocemos, o usamos un comodín con cuidado
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

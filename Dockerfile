# Use official OpenJDK runtime base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY target/*.jar app.jar

EXPOSE 8085

# Set the command to run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]

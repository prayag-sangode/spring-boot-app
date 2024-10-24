# Stage 1: Build the application
FROM maven:3.8.5-openjdk-11 AS build
WORKDIR /app

# Copy the pom.xml and src directory to the build context
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/myapp-0.0.1-SNAPSHOT.jar myapp.jar

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "myapp.jar"]

# Expose the application port (default is 8080)
EXPOSE 8080

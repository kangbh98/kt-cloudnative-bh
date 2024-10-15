# Step 1: Use Maven for the build phase
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the necessary files and build the project
COPY . /app
RUN mvn clean package

# Step 2: Create the runtime image using JDK 17 Temurin
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/target/firstproject-0.0.1-SNAPSHOT.jar /app/firstproject-0.0.1-SNAPSHOT.jar

# Expose the application on port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/firstproject-0.0.1-SNAPSHOT.jar"]

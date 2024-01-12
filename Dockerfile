# Build with docker buildx build --platform linux/arm64,linux/amd64 -t yourname/image-name:tag . --push
# Start with a base image containing Java runtime
FROM maven:3.8.4-openjdk-11-slim as build

# Make app's source directory
WORKDIR /app

# Copy the project files
COPY src /app/src
COPY pom.xml /app

# Package the application
RUN mvn clean package

# Use openjdk image for smaller final image
FROM openjdk:11-jre-slim

# Copy packaged jar file from the build image
COPY --from=build /app/target/dsddemo-1.0-SNAPSHOT.jar /usr/local/lib/dsddemo-1.0-SNAPSHOT.jar

# Run the jar file 
ENTRYPOINT ["java","-jar","/usr/local/lib/dsddemo-1.0-SNAPSHOT.jar"]
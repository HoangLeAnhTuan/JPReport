# Multi-stage build để tối ưu kích thước image
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build

# Set working directory
WORKDIR /app

# Copy pom.xml và download dependencies trước (để cache layer)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code và build application
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

# Install curl và wget cho health check
RUN apk add --no-cache curl wget

# Create non-root user
RUN addgroup -S spring && adduser -S spring -G spring

# Set working directory
WORKDIR /app

# Copy jar file từ build stage
COPY --from=build /app/target/*.jar app.jar

# Change ownership
RUN chown -R spring:spring /app
USER spring

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Run application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

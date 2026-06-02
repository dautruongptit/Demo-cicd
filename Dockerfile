# ============================
# Stage 1: Build
# ============================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml trước để cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source và build
COPY src ./src
RUN mvn clean package -DskipTests -B

# ============================
# Stage 2: Run
# ============================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Tạo user non-root để bảo mật
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy jar từ build stage
COPY --from=builder /app/target/*.jar app.jar

# Đổi owner
RUN chown appuser:appgroup app.jar

USER appuser

EXPOSE 8080

# JVM tuning cho container nhỏ
ENTRYPOINT ["java", \
  "-XX:+UseContainerSupport", \
  "-XX:MaxRAMPercentage=75.0", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]

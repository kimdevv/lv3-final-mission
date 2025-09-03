# --- Build stage ---
FROM gradle:8.10.2-jdk21 AS build
WORKDIR /app

# gradle 캐싱 최적화를 위해 gradle 관련 파일 먼저 복사
COPY build.gradle settings.gradle gradlew ./
COPY gradle gradle
RUN ./gradlew dependencies --no-daemon || return 0

# 소스 복사 후 빌드 (테스트 제외)
COPY . .
RUN ./gradlew bootJar --no-daemon -x test

# --- Runtime stage ---
FROM eclipse-temurin:21-jdk
WORKDIR /app

# 빌드 산출물 복사
COPY --from=build /app/build/libs/*.jar app.jar

# 실행
ENTRYPOINT ["java", "-jar", "app.jar"]

FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn -e -DskipTests dependency:go-offline

COPY src ./src
RUN mvn -e -DskipTests clean package

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENV SPRING_DATASOURCE_URL=jdbc:oracle:thin:@oracle.fiap.com.br:1521:ORCL
ENV SPRING_DATASOURCE_USERNAME=RM559603
ENV SPRING_DATASOURCE_PASSWORD=220897

ENTRYPOINT ["java", "-jar", "app.jar"]

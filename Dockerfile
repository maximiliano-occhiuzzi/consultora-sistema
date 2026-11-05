
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package -DskipTests


FROM tomcat:10.1-jdk17-temurin-jammy

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/consultora-sistema.war /usr/local/tomcat/webapps/ROOT.war

ENV CATALINA_OPTS="--add-opens=java.base/java.io=ALL-UNNAMED -Dfile.encoding=UTF-8"
EXPOSE 8080

CMD ["catalina.sh", "run"]

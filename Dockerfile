FROM maven:3-eclipse-temurin-17-alpine AS build

COPY pom.xml ./pom.xml
RUN mvn -B dependency:resolve


COPY . ./
RUN ls
RUN mvn -Duser.timezone=Europe/Berlin --batch-mode package

FROM openjdk:17-alpine

COPY --from=build target/homedatabroker-1.0.0-SNAPSHOT.jar /app/homedatabroker.jar

ENV TZ=Europe/Berlin

WORKDIR /app

ENTRYPOINT ["java","-XX:+UnlockExperimentalVMOptions","-XX:+UseContainerSupport","-jar","/app/homedatabroker.jar"]

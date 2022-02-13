FROM maven:3.8.4-jdk-8 AS mavenstage
COPY . /appSources
WORKDIR /appSources
RUN mvn verify

FROM alpine:3.14

EXPOSE 8080

#ENV DB_URL jdbc:hsqldb:file:lavagna

COPY --from=mavenstage /appSources/target /app
COPY --from=mavenstage /appSources/entrypoint.sh .
RUN apk update && apk upgrade
RUN apk add curl
RUN apk add openjdk8-jre-base
RUN apk add ca-certificates && update-ca-certificates && apk add openssl
ENTRYPOINT [ "./entrypoint.sh" ]

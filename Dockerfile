FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:10.1
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

ENV PORT=10000
EXPOSE 10000

CMD ["sh", "-c", "sed -i \"s/8080/${PORT}/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]git add .
                                                                                                   git commit -m "Cambiar a Tomcat 10 (Jakarta)"
                                                                                                   git push
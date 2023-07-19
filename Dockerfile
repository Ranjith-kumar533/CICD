FROM tomcat
WORKDIR app/
COPY ./target/*.jar /usr/local/tomcat/webapps
EXPOSE 8080
FROM ubuntu
MAINTAINER prashanth
RUN mkdir -p /user/app
RUN chmod 777 /user/app
WORKDIR /user/app
COPY /test/properties /user/app
COPY /test/service /user/app
COPY start.sh /user/app
RUN apt-get update && apt-get install -y unzip curl wget vim
RUN apt-get update && apt-get install -y openjdk-8-jdk && apt-get install maven -y
RUN apt-get update && apt-get install -y git curl wget net-tools
RUN cd /opt && \
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.4.zip && \
    unzip sonarqube-6.4.zip -d /opt && \
    mv /opt/sonarqube-6.4 /opt/sonarqube && \
    cat /user/app/properties > /opt/sonarqube/conf/sonar.properties && \
    cat /user/app/service > /etc/systemd/system/sonar.service
RUN chmod +x /opt/sonarqube/bin/linux-x86-64/sonar.sh
RUN chmod +x start.sh
EXPOSE 9000
CMD /user/app/start.sh ; sleep infinity


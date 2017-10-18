FROM sonarqube:6.5
MAINTAINER Marco Pas "alan@planet9energy.com"
VOLUME "$SONARQUBE_HOME/extensions"
ENV MINUS_D_PARAMS=""
# create plugin download location; so we can copy them later when SonarQube is started
ENV PLUGIN_DOWNLOAD_LOCATION /opt/plugins-download
RUN mkdir -p $PLUGIN_DOWNLOAD_LOCATION
WORKDIR ${PLUGIN_DOWNLOAD_LOCATION}
RUN wget https://github.com/sleroy/SonarEsLintPlugin/releases/download/v0.1.1/sonar-eslint-plugin-0.1.1.jar
RUN wget https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-3.2.0.5506.jar

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
RUN chmod +x $SONARQUBE_HOME/bin/run.sh

COPY docker-entrypoint.sh /opt/docker-entrypoint.sh
RUN chmod +x /opt/docker-entrypoint.sh
WORKDIR ${SONARQUBE_HOME}
ENTRYPOINT ["/opt/docker-entrypoint.sh"]


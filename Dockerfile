###########
# WebVOWL #
###########

# Use tomcat java 8 alpine as base image
FROM tomcat:9-jre8-alpine

# Build time arguments (WebVOWL version)
ARG version=1.1.7###########
# WebVOWL #
###########

# Use tomcat java 8 alpine as base image
FROM tomcat:9-jre8-alpine

# Build time arguments (WebVOWL version)
ARG version=1.1.7

# Download WebVOWL to tomcat webapps directory as root app
RUN rm -rf /usr/local/tomcat/webapps/* && \
    wget -O /usr/local/tomcat/webapps/ROOT.war https://github.com/DrSnowbird/WebVOWL-docker/raw/master/webvowl_1.1.7.war

# Add a custom entrypoint script
COPY ./ontologies/GraphDB-export.json /tmp/GraphDB-export.json
COPY copy-ontology.sh /usr/local/tomcat/bin/copy-ontology.sh

# Make the script executable
RUN chmod +x /usr/local/tomcat/bin/copy-ontology.sh

# Start Tomcat using the custom entrypoint script
ENTRYPOINT ["/usr/local/tomcat/bin/copy-ontology.sh"]


# Download WebVOWL to tomcat webapps directory as root app
RUN rm -rf /usr/local/tomcat/webapps/* && \
    wget -O /usr/local/tomcat/webapps/ROOT.war https://github.com/DrSnowbird/WebVOWL-docker/raw/master/webvowl_1.1.7.war

# Copy the ontology file to the correct directory in WebVOWL
#COPY ./ontologies/GraphDB-export.json /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/static/data/ct.json


# Run default server
CMD ["catalina.sh", "run"]


#!/bin/sh

# Start Tomcat in the background to allow extraction
catalina.sh start

# Wait for the ROOT.war to be extracted
while [ ! -d "/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/static/data" ]; do
  echo "Waiting for ROOT.war to extract..."
  sleep 5
done

# Copy the ontology file after extraction
cp /tmp/GraphDB-export.json /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/static/data/ct.json
echo "Ontology file copied."

# Stop the background Tomcat and restart in the foreground
catalina.sh stop
catalina.sh run

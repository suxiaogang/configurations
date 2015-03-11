#!/bin/bash

echo "###Delete Old Project####"
cd /usr/local/tomcat/webapps/
rm -rf ROOT.war
rm -rf ROOT
echo "###Delete Finished and list the webapp directory...####"
ls -la

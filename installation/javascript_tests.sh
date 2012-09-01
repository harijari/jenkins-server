#!/bin/bash

#Install jascript lint version fork, friendly for jenkins
wget http://jslint4java.googlecode.com/files/jslint4java-2.0.2-dist.zip -O jslint4java.zip
unzip jslint4java.zip jslint4java-2.0.2/jslint4java-2.0.2.jar
mkdir -p /usr/local/share/jslint4java
mv  jslint4java-2.0.2/jslint4java-2.0.2.jar  /usr/local/share/jslint4java/jslint4java.jar 

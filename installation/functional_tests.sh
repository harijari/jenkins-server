#!/bin/bash

# Download required tools, ie dummy X server and webbrowsers
apt-get -y install xvfb

# Firefox
apt-get -y install iceweasel

# Chromium
apt-get -y install chromium-browser

# Download selenium runner (there is no such deb package
mkdir -p /usr/local/share/selenium
wget http://selenium.googlecode.com/files/selenium-server-standalone-2.25.0.jar
mv selenium-server-standalone-2.25.0.jar /usr/local/share/selenium/selenium-server.jar

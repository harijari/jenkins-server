#!/bin/bash


# Add jenkins repository
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
apt-get update

# Install newest version of jenkins
apt-get -y install jenkins
sleep 30

# Get the update center ourself
wget -O default.js http://updates.jenkins-ci.org/update-center.json
 
# remove first and last line javascript wrapper
sed '1d;$d' default.js > default.json
 
# Now push it to the update URL
curl -X POST -H "Accept: application/json" -d @default.json http://localhost:8080/updateCenter/byId/default/postBack --verbose

# Add jenkins user to shadow group. This is required, to make authentication in
# jenkins work
usermod -a -G shadow jenkins


# We are using unix based users and groups
# This is general, administration group. All users which are belong
# to this group are jenkins administrators
groupadd JENKINS-ADMIN

# One group per project, for example this one is for base-* projects 
groupadd JENKINS-BASE

# Add jenkins admin to unix passwd
useradd -N -s /bin/false -g JENKINS-ADMIN jenkins_admin
# todo: Set password automagically

# Retrieve jenkins cli tool
wget http://localhost:8080/jnlpJars/jenkins-cli.jar


# Retrieve bunch of jenkins plugins
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin performance
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin greenballs
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin ant
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin javadoc
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin jdepend
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin token-macro
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin violations
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin htmlpublisher
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin analysis-core
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin dry
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin pmd
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin plot
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin disk-usage
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin subversion
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin redmine
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin doxygen
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin nested-view
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin clone-workspace-scm
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin project-description-setter
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin checkstyle
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin log-parser 
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin git
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin performance
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin seleniumhtmlreport
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin pegdown-formatter
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin template-project
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin clover
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin xunit
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin jsunit
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin envinject
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin phing


# Override jenkins configuration
cp configuration/config.xml /var/lib/jenkins/config.xml
chown jenkins.nogroup /var/lib/jenkins/config.xml
chmod 644 /var/lib/jenkins/config.xml
java -jar jenkins-cli.jar -s http://localhost:8080/ restart 
sleep 30

# Import base projects
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base < configuration/base-jobs/base.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-checkout < configuration/base-jobs/base-checkout.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-code-review < configuration/base-jobs/base-code-review.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-documentation < configuration/base-jobs/base-documentation.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-functional < configuration/base-jobs/base-functional.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-install < configuration/base-jobs/base-install.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-performance < configuration/base-jobs/base-performance.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-security < configuration/base-jobs/base-security.xml
java -jar jenkins-cli.jar -s http://localhost:8080 create-job base-unit < configuration/base-jobs/base-unit.xml





apt-get -y install git
apt-get -y install ant

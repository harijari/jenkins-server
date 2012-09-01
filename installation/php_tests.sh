#!/bin/bash

apt-get -y install php-pear
#teraz konfigurujemy PHP i instalujemy potrzebne narzedzia
pear channel-discover pear.pdepend.org 
pear channel-discover pear.phpmd.org 
pear channel-discover pear.phpunit.de
pear channel-discover components.ez.no
pear channel-discover pear.symfony-project.com

pear upgrade pear
# Install pdepepend tool (PHP Depend, port of JDepend)
pear install pdepend/PHP_Depend-beta

# Install phpmd (PHP Mess detectory)
pear install --alldeps phpmd/PHP_PMD-alpha

# Install PHP Copy Paste detector
pear install --alldeps phpunit/phpcpd

# Install PHPDocumentor 
pear install PHPDocumentor

# Install phpcs tool
pear install PHP_CodeSniffer

# Install phpunit
pear install --alldeps phpunit/PHP_CodeBrowser-alpha
pear install --alldeps phpunit/PHPUnit

# Install phploc
pear install --alldeps phpunit/phploc

# Install drush (for drupal related tasks)
pear channel-discover pear.drush.org
pear install drush/drush


apt-get -y  install doxygen

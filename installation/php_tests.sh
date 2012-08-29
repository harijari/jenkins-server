#!/bin/bash

apt-get install php-pear
#teraz konfigurujemy PHP i instalujemy potrzebne narzedzia
pear channel-discover pear.pdepend.org 
pear channel-discover pear.phpmd.org 
pear channel-discover pear.phpunit.de
pear channel-discover components.ez.no

pear upgrade pear
pear install pdepend/PHP_Depend-beta
pear install --alldeps phpmd/PHP_PMD-alpha
pear install --alldeps phpunit/phpcpd
pear install PHPDocumentor
pear install PHP_CodeSniffer
pear install --alldeps phpunit/PHP_CodeBrowser-alpha
pear install --alldeps phpunit/PHPUnit


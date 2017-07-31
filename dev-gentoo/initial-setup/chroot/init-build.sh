#!/bin/bash
#===============================================================================
# init-build.sh: Initialises and Configures Build System
#
# Usage: init-build.sh
#===============================================================================

jenkins_args='--httpPort=web.local --prefix=/jenkins'

escaped_args=$(echo $jenkins_args | sed 's/[]\/$*.^|[]/\\&/g')
sed -i "s/JENKINS_ARGS=\"\"/JENKINS_ARGS=\"$escaped_args\"" /etc/conf.d/jenkins

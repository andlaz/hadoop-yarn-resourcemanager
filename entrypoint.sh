#!/usr/bin/env bash

# Allow parameters to configure.rb to come from CONFIGURE_PARAMS as opposed to stdin
# This is to support parameterizing via Compose in particular. The two lines below are equivalent in effect:
# docker run -e "CONFIGURE_PARAMS=cassandra --dc daas-1 --calculate-tokens 1:1" -ti --name c1 --rm andlaz/hadoop-cassandra
# docker run -ti --name c1 --rm andlaz/hadoop-cassandra cassandra --dc daas-1 --calculate-tokens 1:1
P=${CONFIGURE_PARAMS:-$(echo $*)}
set -- $P

case $1 in
	help) ruby /root/configure.rb $* ;;
	*) ruby /root/configure.rb $* && supervisord -c /etc/supervisord.conf
esac

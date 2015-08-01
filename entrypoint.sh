#!/usr/bin/env bash

ruby /root/configure.rb $*
supervisord -c /etc/supervisord.conf
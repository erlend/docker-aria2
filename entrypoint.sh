#!/bin/sh

if [ -z "$1" ] || [ ${1:0:1} = '-' ]; then
  echo Running scripts in /etc/startup
  run-parts /etc/startup

  set -- su-exec aria2 dumb-init aria2c $@
fi

exec $@

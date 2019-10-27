#!/bin/bash

# -------------------------------------------------
# To overcome pretty annoying "no such file or directory" error
#
# http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/
#
# -------------------------------------------------

mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server

exec shiny-server >> /var/log/shiny-server.log 2>&1


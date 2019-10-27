#!/bin/sh

touch /var/log/shiny-server.log
chown shiny:shiny /var/log/shiny-server.log

# run shiny server
exec sudo -u shiny shiny-server >> /var/log/shiny-server.log 2>&1

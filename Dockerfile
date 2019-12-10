# ----------------------------------------
#
# This image inherits uoa-inzight-lite-base image, 
# updates packages from docker.stat.auckland.ac.nz 
# repository and installs the shiny app for Lite
#
# ----------------------------------------
FROM cttc101/lite-package:latest

MAINTAINER "Science IS Team" ws@sit.auckland.ac.nz

# Edit the following environment variable, commit to Github and it will trigger Docker build
# Since we fetch the latest changes from the associated Application~s master branch
# this helps trigger date based build
# The other option would be to tag git builds and refer to the latest tag
ENV LAST_BUILD_DATE "Thu 24 10 21:45:00 NZDT 2019"

# Install (via R) all of the necessary packages (R will automatially install dependencies):
RUN rm -rf /srv/shiny-server/* \ 
  && wget --no-verbose -O test.zip https://github.com/t0ngchen/test/archive/master.zip \
  && unzip test.zip \
  && cp -R test-master/* /srv/shiny-server/ \
  && rm -rf test.zip test-master \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#  && chown -R shiny:shiny /var/lib/shiny-server

CMD ["/opt/shiny-server.sh"]

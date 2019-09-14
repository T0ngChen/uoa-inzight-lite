# ----------------------------------------
#
# This image inherits uoa-inzight-lite-base image, 
# updates packages from docker.stat.auckland.ac.nz 
# repository and installs the shiny app for Lite
#
# ----------------------------------------
FROM scienceis/uoa-inzight-lite-base:play

MAINTAINER "Science IS Team" ws@sit.auckland.ac.nz

# Edit the following environment variable, commit to Github and it will trigger Docker build
# Since we fetch the latest changes from the associated Application~s master branch
# this helps trigger date based build
# The other option would be to tag git builds and refer to the latest tag
ENV LAST_BUILD_DATE "Thu 13 06 21:45:00 NZDT 2019"

RUN R -e "install.packages('ggmosaic', repos = 'https://cran.r-project.org', type = 'source', dependencies = TRUE)" \
&& R -e "install.packages('ggbeeswarm', repos = 'https://cran.r-project.org', type = 'source', dependencies = TRUE)" \
&& R -e "install.packages('ggridges', repos = 'https://cran.r-project.org', type = 'source', dependencies = TRUE)" \
&& R -e "install.packages('waffle', repos = 'https://cran.r-project.org', type = 'source', dependencies = TRUE)" \
&& R -e "install.packages('plotly', repos = 'https://cran.r-project.org', type = 'source', dependencies = TRUE)" \
&& R -e "install.packages('https://r.docker.stat.auckland.ac.nz/src/contrib/iNZightTools_1.7.4.tar.gz', repos = NULL, type = 'source', dependencies = TRUE)" \
&& R -e "install.packages('https://r.docker.stat.auckland.ac.nz/src/contrib/iNZightPlots_2.10.2.tar.gz', repos = NULL, type = 'source', dependencies = TRUE)" \

# Install (via R) all of the necessary packages (R will automatially install dependencies):
RUN rm -rf /srv/shiny-server/* \
  && wget --no-verbose -O Lite.zip https://github.com/iNZightVIT/Lite/archive/master.zip \
  && unzip Lite.zip \
  && cp -R Lite-master/* /srv/shiny-server \
  && echo $LAST_BUILD_DATE > /srv/shiny-server/build.txt \
  && rm -rf Lite.zip Lite-master/ \
  && rm -rf /tmp/* /var/tmp/*

# start shiny server process - it listens to port 3838
CMD ["/opt/shiny-server.sh"]

FROM ubuntu:16.04

# basics
RUN apt-get update && \
    apt-get install -y software-properties-common firefox xvfb wget && \
    apt-add-repository -y ppa:rael-gc/rvm && \
    apt-get update && \
    apt-get install -y rvm

ENV  RUBY_VERSION 2.7.0
RUN  /bin/bash -l -c "rvm install $RUBY_VERSION" && \
     /bin/bash -l -c "gem install bundler --no-document"

ENV   GECKODRIVER_VERSION v0.30.0 
RUN   mkdir -p /opt/geckodriver_folder && \
      wget -O /tmp/geckodriver_linux64.tar.gz https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
      tar xf /tmp/geckodriver_linux64.tar.gz -C /opt/geckodriver_folder && \
      rm /tmp/geckodriver_linux64.tar.gz && \
      chmod +x /opt/geckodriver_folder/geckodriver && \
      ln -fs /opt/geckodriver_folder/geckodriver /usr/local/bin/geckodriver

RUN mkdir /app
WORKDIR /app
RUN /bin/bash -l -c "gem update"

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN /bin/bash -l -c "bundle install"

ADD features /app/features
ADD build /app/build

ADD cucumber-run.sh /app/cucumber-run.sh
RUN chmod a+x /app/cucumber-run.sh

CMD /bin/bash -l -c "xvfb-run --server-args='-screen 0 1440x900x24' bash cucumber-run.sh"

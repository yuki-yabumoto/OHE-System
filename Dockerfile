FROM ruby:3.0.1

RUN apt-get update \
    && apt-get -y install postgresql

RUN gem install rails

CMD tail -f /dev/null
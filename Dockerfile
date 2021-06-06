FROM ruby:3.0.1

RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update \
    && apt-get install -y --no-install-recommends nodejs mariadb-server mariadb-client

RUN apt-get install -y curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update \
    && apt-get install -y yarn

RUN gem install rails

RUN apt install imagemagick

COPY ./setup.sh /tmp/setup.sh
RUN chmod 755 /tmp/setup.sh
CMD [ "bash", "/tmp/setup.sh" ]
FROM ruby:3.0.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends node.js mariadb-server mariadb-client

RUN apt-get install -y curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN gem install rails

COPY ./setup.sh /tmp/setup.sh
RUN chmod 755 /tmp/setup.sh
CMD [ "bash", "/tmp/setup.sh" ]
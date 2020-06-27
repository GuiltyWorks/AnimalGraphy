FROM ruby:2.7

RUN mkdir /AnimalGraphy
ENV APP_ROOT /AnimalGraphy
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs imagemagick && \
    gem install bundler && \
    bundle install

COPY . $APP_ROOT

RUN mkdir -p log tmp/pids tmp/sockets

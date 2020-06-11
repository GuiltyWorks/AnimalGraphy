FROM ruby:2.7

RUN mkdir /AnimalGraphy
ENV APP_ROOT /AnimalGraphy
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN apt update && \
    apt upgrade -y && \
    apt install -y build-essential libpq-dev nodejs imagemagick && \
    gem install bundler && \
    bundle install

COPY . $APP_ROOT

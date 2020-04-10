FROM ruby:2.7

RUN apt update -qq \
    && apt install -y build-essential libpq-dev nodejs imagemagick \
    && mkdir /AnimalGraphy

WORKDIR /AnimalGraphy
ADD Gemfile /AnimalGraphy/Gemfile
ADD Gemfile.lock /AnimalGraphy/Gemfile.lock
RUN bundle install
ADD . /AnimalGraphy

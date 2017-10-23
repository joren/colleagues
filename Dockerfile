FROM ruby:2.3-alpine
MAINTAINER joren

# Needed to build json and download gems from git
RUN apk update && apk add --no-cache g++ musl-dev make git && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/colleagues
WORKDIR /var/www/colleagues
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
COPY colleagues.rb .
COPY config.ru .
COPY public/ public/
COPY views/ views/

ENV BIND 0.0.0.0

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]

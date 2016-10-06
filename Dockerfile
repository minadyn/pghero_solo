FROM ruby:2.3.0
MAINTAINER Danny Im "minadyn@gmail.com"

# Install dependencies for gems
RUN apt-get update -y && apt-get -y install libpq-dev

# Add and install gem dependencies
ADD Gemfile       /app/Gemfile
ADD Gemfile.lock  /app/Gemfile.lock
ADD . /app
RUN bash -l -c "cd /app && bundle install -j4"

#ADD . /app

WORKDIR /app
EXPOSE 8080

CMD bundle exec puma -t ${PUMA_MIN_THREADS:-8}:${PUMA_MAX_THREADS:-12} -w ${PUMA_WORKERS:-1} -p 8080 -e ${RACK_ENV:-production} --preload

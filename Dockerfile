FROM ruby:2.6.3
RUN apt-get update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install -y nodejs
RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v '2.0.2' && bundle install --jobs 20 --retry 5
COPY . ./
EXPOSE 3000

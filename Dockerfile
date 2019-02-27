# Pull Ruby environment from Docker Hub
FROM ruby:2.4.1

# Update libraries within image, install nano, Postgres library,
# nodejs, bundler, and nokogiri
RUN apt-get update -qq && \
    apt-get install -y nano build-essential libpq-dev nodejs && \
    gem install bundler && \
    gem install nokogiri

# Create folder for project
RUN mkdir /portfolio-website

# Copy files from Host to containerized app
COPY Gemfile Gemfile.lock /portfolio-website/

# Set working directory
WORKDIR /portfolio-website

# Run bundle install within the project
RUN bundle install

# Copy the rest of the content in Host to containerized service
COPY . /portfolio-website
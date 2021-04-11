# FROM ruby:2.5.8
FROM phusion/passenger-ruby25:1.0.13

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default
ADD ./docker/nginx/confd/app.conf /etc/nginx/sites-enabled/app.conf

RUN apt-get update && \
    apt-get install -y nano libpq-dev && \
    gem install bundler && \
    gem install nokogiri

RUN mkdir /home/app/checo-portfolio
ADD Gemfile Gemfile.lock /home/app/checo-portfolio/
WORKDIR /home/app/checo-portfolio
RUN bundle install --deployment --without development test
COPY --chown=app:app . /home/app/checo-portfolio/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/service/nginx/down
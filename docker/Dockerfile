FROM phusion/passenger-full:1.0.13

RUN bash -lc 'rvm --default use ruby-2.4.1'

RUN apt-get update && \
    apt-get install -y nano build-essential libpq-dev && \
    gem install bundler && \
    gem install nokogiri

RUN rm /etc/nginx/sites-enabled/default
ADD ./docker/nginx/confd/app.conf /etc/nginx/sites-enabled/checo-portfolio.conf
RUN mkdir /var/www/checo-portfolio
COPY Gemfile Gemfile.lock /var/www/checo-portfolio/
WORKDIR /var/www/checo-portfolio
RUN bundle install
COPY . /var/www/checo-portfolio
COPY --chown=app:app . /var/www/checo-portfolio
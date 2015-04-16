FROM phusion/passenger-ruby22
ENV HOME /root
WORKDIR /home/app
ADD Gemfile /home/app/Gemfile
RUN bundle install
ADD . /home/app
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#nginx
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf
ADD postgres-env.conf /etc/nginx/main.d/postgres-env.conf

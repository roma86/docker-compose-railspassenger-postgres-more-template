#Ruby on Rails simple stack

**Database:** postgres

**Application server:** Phusion Passenger

####Note:

Stack is configured for an single app

##Usage

- Install docker
- Install docker-compose
- Clone this template
- Check Gemfile
- Check Dockerfile
- Check dockerp-compose.yml
- Check nginx configs:
  + webapp.conf
  + secret_key.conf
  + gzip_max.conf
  + postgres-env.conf
- Inside project dir run:
  ```bash

    docker-compose run web
    docker-compose up
    docker-compose run web rake db:create

  ```

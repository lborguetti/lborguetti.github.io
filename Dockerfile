FROM ruby

MAINTAINER Luciano Antonio Borguetti Faustino <lucianoborguetti@gmail.com>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install nodejs-legacy
RUN apt-get clean
RUN gem install github-pages

WORKDIR /srv

RUN jekyll new jekyll

WORKDIR /srv/jekyll

EXPOSE 4000

CMD jekyll serve

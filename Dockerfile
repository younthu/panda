FROM ruby:3.1.1

WORKDIR /app

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get install libmagickwand-dev

COPY Gemfile Gemfile.lock ./

# 下面两行是panda engine专用，不要进docker template
COPY panda.gemspec* ./
COPY lib/panda/version* ./lib/panda/

RUN gem install bundler

RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
    && bundle config mirror.https://rubygems.org https://gems.ruby-china.com

RUN bundle install

COPY ./ ./
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 3000
ENTRYPOINT [ "entrypoint.sh" ]
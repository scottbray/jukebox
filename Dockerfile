# DEVELOPMENT DOCKERFILE

FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

ENV RAILS_SERVE_STATIC_FILES "true"
ENV SECRET_KEY_BASE "77fffdfe5e2ba44aad3018e4f4bf0f0636d4e9d790c3fcc27078cb2ec1b964dfea3d732300c7fc0a91a59de4bd097e3c91f8ade55a717961dad4f56fbac07949"
RUN rails assets:clobber && rails assets:precompile

EXPOSE 3333
CMD ["rails", "server"]
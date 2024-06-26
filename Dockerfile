# This is a multi-stage image build. The rationale is to copy compiled files
# from the base stage, leaving unnecessary build tools and libraries out of
# the runtime image. This results in a smaller image with fewer attack vectors
# It also improves build times by caching the base stage.

# Base stage
FROM public.ecr.aws/docker/library/ruby:3.2.2-alpine AS base
RUN apk add build-base curl git libc-utils libpq-dev nodejs tzdata && rm -rf /var/cache/apk/*

# Set locale and timezone
RUN echo "Europe/London" > /etc/timezone
RUN echo 'export LC_ALL=en_GB.UTF-8' >> /etc/profile.d/locale.sh && \
  sed -i 's|LANG=C.UTF-8|LANG=en_GB.UTF-8|' /etc/profile.d/locale.sh

RUN YARN_VERSION=1.9.4 \
  set -ex \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && mkdir -p /opt/yarn \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz

ENV INSTALL_PATH /srv/dss
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

# set rails environment
ARG RAILS_ENV
ENV RAILS_ENV=${RAILS_ENV:-production}
ENV RACK_ENV=${RAILS_ENV:-production}

COPY Gemfile Gemfile.lock $INSTALL_PATH/
COPY package.json yarn.lock $INSTALL_PATH/
COPY Rakefile $INSTALL_PATH/

RUN yarn
RUN gem update --system

# bundle ruby gems based on the current environment, default to production
RUN echo $RAILS_ENV
RUN \
  if [ "$RAILS_ENV" = "production" ]; then \
    bundle config set --local without 'development test' && bundle install --jobs 4 --retry 10; \
  else \
    bundle install --jobs 4 --retry 10; \
  fi

COPY . $INSTALL_PATH

RUN bundle exec rake AWS_ACCESS_KEY_ID=dummy AWS_SECRET_ACCESS_KEY=dummy AWS_S3_REGION=dummy AWS_S3_BUCKET=dummy SECRET_KEY_BASE=dummy DATABASE_URL=postgresql:does_not_exist --quiet assets:precompile

# Runtime stage
FROM public.ecr.aws/docker/library/ruby:3.2.2-alpine
ENV INSTALL_PATH /srv/dss
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN apk upgrade && apk add curl libpq nodejs && rm -rf /var/cache/apk/*
COPY --from=base /etc/profile.d/locale.sh /etc/profile.d/locale.sh
COPY --from=base /etc/timezone /etc/timezone
COPY --from=base /usr/local/bundle /usr/local/bundle
COPY --from=base /usr/share/zoneinfo /usr/share/zoneinfo
COPY . $INSTALL_PATH
COPY --from=base $INSTALL_PATH/node_modules $INSTALL_PATH/node_modules
COPY --from=base $INSTALL_PATH/public/assets $INSTALL_PATH/public/assets
RUN mv docker-entrypoint.sh /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh

# Run as non-root user
RUN addgroup -g 1000 ccs && adduser -D -u 1000 -G ccs rmi && chown -R rmi:ccs $INSTALL_PATH
USER rmi:ccs

EXPOSE 3100

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rails", "server"]

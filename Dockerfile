FROM fluent/fluentd:v1.14-1

MAINTAINER Denis Odilon

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install fluent-plugin-concat -v 2.5.0 \
 && sudo gem install fluent-plugin-jq -v 0.5.1 \
 && sudo gem install fluent-plugin-splunk-hec -v 1.2.11 \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

USER fluent
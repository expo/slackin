FROM node:7.6-alpine
RUN apk add --no-cache make gcc g++ python

COPY package.json /srv/www/
WORKDIR /srv/www
RUN npm install --ignore-scripts --unsafe-perm

COPY . /srv/www/
RUN npm run postinstall

ARG SLACK_SUBDOMAIN
ARG SLACK_API_TOKEN
ENV SLACK_SUBDOMAIN $SLACK_SUBDOMAIN
ENV SLACK_API_TOKEN $SLACK_API_TOKEN

ENV PORT 3000
EXPOSE $PORT

CMD ./bin/slackin --coc "$SLACK_COC" --channels "$SLACK_CHANNELS" --port $PORT $SLACK_SUBDOMAIN $SLACK_API_TOKEN

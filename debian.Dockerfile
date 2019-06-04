# pull repository
FROM alpine/git AS git-clone
RUN mkdir -p /app/src && \
    git clone https://github.com/vijos/vj4.git /app/src

# `stage-node` generates some files
FROM node:8-stretch AS stage-node
COPY --from=git-clone /app/src /app/src
WORKDIR /app/src

RUN npm install \
    && npm run build:production

# main
FROM python:3.6-slim-stretch
COPY --from=stage-node /app/src/vj4 /app/vj4
COPY --from=stage-node /app/src/LICENSE /app/src/README.md /app/src/requirements.txt /app/src/setup.py /app/
WORKDIR /app

RUN apt-get update && \
    apt-get install -y libmaxminddb0 mmdb-bin \
        libmaxminddb-dev git build-essential curl && \
    python3 -m pip install -r requirements.txt && \
    curl "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz" | gunzip -c > GeoLite2-City.mmdb && \
    apt-get purge -y \
        libmaxminddb-dev git build-essential curl && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV GIT_PYTHON_REFRESH=quiet
ENV VJ_LISTEN=http://0.0.0.0:8888

ADD docker-entrypoint.py /app/
ENTRYPOINT [ "python3", "docker-entrypoint.py" ]

EXPOSE 8888
CMD [ "vj4.server" ]

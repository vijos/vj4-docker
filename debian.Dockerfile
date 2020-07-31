# pull repository
FROM alpine/git AS git-clone
RUN mkdir -p /app/src && \
    git clone https://github.com/vijos/vj4.git /app/src

# `stage-node` generates some files
FROM node:12-buster AS stage-node
COPY --from=git-clone /app/src /app/src
WORKDIR /app/src

RUN yarn \
    && yarn build:production

# main
FROM python:3.6-slim-buster
COPY --from=stage-node /app/src/vj4 /app/vj4
COPY --from=stage-node /app/src/LICENSE /app/src/README.md /app/src/requirements.txt /app/src/setup.py /app/
WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
        git build-essential && \
    python3 -m pip install -r requirements.txt && \
    apt-get purge -y \
        git build-essential && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV GIT_PYTHON_REFRESH=quiet
ENV VJ_LISTEN=http://0.0.0.0:8888

ADD docker-entrypoint.py /app/
ENTRYPOINT [ "python3", "docker-entrypoint.py" ]

EXPOSE 8888
CMD [ "vj4.server" ]

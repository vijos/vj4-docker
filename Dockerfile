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
FROM python:3.6-alpine3.12
COPY --from=stage-node /app/src/vj4 /app/vj4
COPY --from=stage-node /app/src/LICENSE /app/src/README.md /app/src/requirements.txt /app/src/setup.py /app/
WORKDIR /app

RUN apk add --no-cache \
        alpine-sdk git && \
    python -m pip install -r requirements.txt && \
    apk del --no-cache --purge \
        alpine-sdk git

ENV GIT_PYTHON_REFRESH=quiet
ENV VJ_LISTEN=http://0.0.0.0:8888

ADD docker-entrypoint.py /app/
ENTRYPOINT [ "python", "docker-entrypoint.py" ]

EXPOSE 8888
CMD [ "vj4.server" ]

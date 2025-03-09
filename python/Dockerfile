# syntax=docker/dockerfile:1.3-labs
FROM python:3.9 AS base
RUN apt-get update && apt-get install -y \
    iputils-ping \
    less \    
    net-tools \
    procps \
    supervisor \
    telnet \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

FROM base AS dev
ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip ./awscliv2.zip
RUN unzip awscliv2.zip \
    && ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update \
    && curl -so- https://raw.githubusercontent.com/realfabecker/kevin/master/install.sh | bash \
    && chmod +x /root/bin/kevin \
    && mv /root/bin/kevin /usr/local/bin/kevin \
    && addgroup nonroot --gid 1000 \
    && adduser --uid 1000 --gid 1000 nonroot
USER nonroot
WORKDIR /home/nonroot/app
ENV PATH="${PATH}:/home/nonroot/.local/bin"
RUN pip install --upgrade pip
RUN pip install pipenv --user
COPY Pipfile .
RUN pipenv install

FROM base AS prod
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
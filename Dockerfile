FROM golang:1.11.11-alpine3.8 AS cst-builder

RUN apk add --no-cache \
      gcc~=6.4 \
      git~=2.18 \
      make~=4.2 \
      musl-dev~=1.1 \
    && go get github.com/golang/dep/cmd/dep

# container-structure-test default version
ARG CST_REF=v1.6.0
ENV SOURCE_PATH=/go/src/github.com/GoogleContainerTools/container-structure-test

RUN git clone \
    --depth 1 https://github.com/GoogleContainerTools/container-structure-test.git \
    --branch "$CST_REF" \
    "$SOURCE_PATH"

WORKDIR $SOURCE_PATH
# Download dependencies
RUN dep ensure
# Compile code
RUN VERSION=$(git describe --tags || echo "$CST_REF-$(git describe --always)") make \
  && cp out/container-structure-test /

# Distro image
FROM ubuntu:18.04
LABEL maintainers="João Rosa <joaoasrosa@gmail.com>"

ENV CST_VERSION=1.6.0
ENV DOCKER_VERSION=18.09.0
ENV NODEJS_VERSION=8.10.0
ENV SNYK_VERSION=1.118.2

COPY --from=cst-builder /container-structure-test /bin/

RUN apt-get -y update
RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN apt-get -y update
RUN apt-get -y install docker-ce
RUN apt-get -y install nodejs npm
RUN npm install -g snyk
FROM microsoft/vsts-agent:ubuntu-16.04-docker-17.12.0-ce-standard
# Replace shell with bash so we can source files.
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo "node anv npm versions" && node -v && npm -v

ARG NPM_VERSION=6.3.0 
ARG NODE_VERSION=8.11.1

RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION=${NODE_VERSION}

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN echo "node anv npm versions" && node -v && npm -v
RUN npm i -g npm@${NPM_VERSION}

RUN echo "node anv npm versions" && node -v && npm -v

# Install az
ARG UPD_CLI="yes"
RUN env
RUN if [ -n "$UPD_CLI" -a "$UPD_CLI" = "yes"   ]; then apt-get update  \
   && apt-get install -y azure-cli ; else echo 'no update' ; fi
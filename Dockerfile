FROM microsoft/vsts-agent:ubuntu-16.04-docker-17.12.0-ce-standard
RUN echo "node anv npm versions" && node -v && npm -v

# ARG NPM_VERSION=6.3.0 
# ARG NODE_VERSION=8.11.1

# ENV NODE_VERSION=${NODE_VERSION}
RUN npm i -g npm@${NPM_VERSION}

# RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
# RUN apt-get install nodejs@8.11.1 -y

RUN echo "node anv npm versions" && node -v && npm -v

# Install az
ARG UPD_CLI="yes"
RUN env
RUN if [ -n "$UPD_CLI" -a "$UPD_CLI" = "yes"   ]; then apt-get update  \
   && apt-get install -y azure-cli ; else echo 'no update' ; fi
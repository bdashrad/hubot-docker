FROM node:latest
MAINTAINER Brad Clark <bdashrad@gmail.com>

# Configure the bot
ENV BOTUSER hubot
ENV HUBOT_ADAPTER slack
ENV HUBOT_DESCRIPTION just a friendly bot
ENV HUBOT_NAME opsbot
ENV HUBOT_OWNER ops@cainc.com
ENV HUBOT_PORT 8080
ENV HUBOT_SLACK_BOTNAME ${HUBOT_NAME}

# Set bot directory
ENV BOTDIR /home/${BOTUSER}
ENV PORT #{HUBOT_PORT}

EXPOSE ${HUBOT_PORT}

# Create user for bot
# yo requires uid/gid 501
RUN groupadd -g 501 ${BOTUSER}
RUN useradd -m -u 501 -g 501 ${BOTUSER}

# Install hubot and dependencies
RUN npm install -g yo generator-${BOTUSER}

# Switch to our new user
USER ${BOTUSER}
RUN cd ${BOTDIR} && mkdir bot
WORKDIR ${BOTDIR}/bot

# Create the hubot
RUN yo hubot --owner ${HUBOT_OWNER} --adapter ${HUBOT_ADAPTER} --name ${HUBOT_NAME} --description ${HUBOT_DESCRIPTION} --defaults

# Add our cutom package.json, external-scripts.json, and scripts/
COPY scripts/ scripts/
COPY package.json package.json
COPY external-scripts.json external-scripts.json
RUN npm install

CMD bin/hubot
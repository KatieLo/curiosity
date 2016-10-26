FROM node:6.3.0

# Create unpriveleged user because we don't want the process inside container to run as root
RUN useradd --user-group --create-home --shell /bin/false app &&\
  npm install

ENV HOME=/home/app

COPY package.json $HOME/curiosity/
# so user can actually read the files
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/curiosity
RUN npm install

# copy app into container as root
USER root
COPY . $HOME/curiosity
RUN chown -R app:app $HOME/*
USER app

CMD ["node", "server.js"]
FROM ubuntu:16.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install python \
                       git \
                       sudo
RUN apt-get -y install nodejs
RUN npm cache clean -f
RUN npm install -g n
RUN n 16.15.1
RUN npm install -g npm@8.12.1
RUN node -v
RUN npm -v
RUN git clone https://github.com/ONLYOFFICE/build_tools.git
RUN cd ./build_tools/tools/linux
RUN ./automate.py server

CMD bash

FROM ubuntu:16.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install python \
                       python3 \
                       git \
                       sudo
RUN rm /usr/bin/python && ln -s /usr/bin/python2 /usr/bin/python
RUN git clone https://github.com/ONLYOFFICE/build_tools.git
RUN cd /root/build_tools/tools/linux
RUN apt install nodejs
RUN npm cache clean -f
RUN npm install -g n
RUN n 16.15.1
RUN npm install -g npm@8.12.1
RUN node -v
RUN npm -v
RUN cd /root/build_tools/tools/linux
RUN ./automate.py server
WORKDIR /root/build_tools

CMD bash

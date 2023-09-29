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
WORKDIR /root/build_tools

CMD cd tools/linux && \
    python3 ./automate.py

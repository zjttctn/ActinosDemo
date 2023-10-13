FROM ubuntu:20.04

# 设置docker中时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install python3 python3-pip git sudo

WORKDIR /codepy

COPY ./requirements.txt /codepy/requirements.txt

RUN pip install --upgrade pip 

RUN pip install --upgrade -r /codepy/requirements.txt

RUN playwright install chrome msedge firefox

RUN apt-get install ttf-wqy-microhei

RUN apt-get install -y libnss3 libx11-xcb1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libxkbcommon0 libxslt1.1 libgtk-3-0 libdbus-glib-1-2

COPY ./main.py /codepy/main.py

CMD ["python", "/codepy/main.py"]

# 以下为尝试构建onlyoffice镜像
# FROM ubuntu:16.04

# ENV TZ=Etc/UTC
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN apt-get -y update && \
#     apt-get -y install python \
#                        git \
#                        sudo
# RUN apt-get -y install nodejs npm curl wget
# RUN npm cache clean -f
# RUN npm install -g n
# RUN n 16.15.1
# RUN npm install -g npm@8.12.1
# RUN node -v
# RUN npm -v
# RUN git clone https://github.com/ONLYOFFICE/build_tools.git
# RUN pwd
# WORKDIR /build_tools/tools/linux
# RUN cd /build_tools/tools/linux
# RUN ./automate.py server

# CMD bash

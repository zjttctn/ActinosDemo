FROM ubuntu:20.04

# 设置docker中时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install python3 python3-pip git sudo curl

# 20231118.添加允许镜像中通过odbc访问sql server。
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get -y update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools && \
    apt-get install -y unixodbc-dev

# 20231118.添加相应命令到搜索路径中: requirements.txt中playwright==1.31.1以后为新扩展有包
RUN ln -s /opt/mssql-tools/bin/bcp /usr/bin/bcp && ln -s /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd

WORKDIR /codepy

COPY ./requirements.txt /codepy/requirements.txt

RUN pip install --upgrade pip 

RUN pip install --upgrade -r /codepy/requirements.txt

RUN playwright install chromium

RUN apt-get install -y ttf-wqy-microhei

RUN apt-get install -y libnss3 libx11-xcb1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libxkbcommon0 libxslt1.1 libgtk-3-0 libdbus-glib-1-2

COPY ./main.py /codepy/main.py

CMD ["python3", "/codepy/main.py"]


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

FROM ubuntu:latest
MAINTAINER pch18.cn

#设置entrypoint和letsencrypt映射到www文件夹下持久化
COPY entrypoint.sh /entrypoint.sh
COPY set_default.py /set_default.py

RUN mkdir -p /www/letsencrypt \
    && ln -s /www/letsencrypt /etc/letsencrypt \
    && mkdir /www/init.d \
    && ln -s /www/init.d /etc/init.d \
    && chmod +x /entrypoint.sh \
    && mkdir /www/wwwroot
    
#更新系统 安装依赖 安装宝塔面板
RUN cd /home \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get -y install sudo wget openssh-server python \
    && echo 'Port 63322' > /etc/ssh/sshd_config \
    && wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh \
    && echo y | bash install.sh \
    && python /set_default.py \
    && python /www/server/panel/tools.py panel password \
    && echo '["linuxsys", "webssh"]' > /www/server/panel/config/index.json 

WORKDIR /www/wwwroot
CMD /entrypoint.sh
EXPOSE 8888 888 21 20 443 80

HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost:8888/ && curl -fs http://localhost/ || exit 1 

FROM aiastia/bt:clear
MAINTAINER ai

RUN bash /www/server/panel/install/install_soft.sh 0 install nginx 1.17
RUN bash /www/server/panel/install/install_soft.sh 0 install php 7.3 || echo 'Ignore Error'
RUN bash /www/server/panel/install/install_soft.sh 0 install mysql 5.7
RUN bash /www/server/panel/install/install_soft.sh 0 install phpmyadmin 4.9 || echo 'Ignore Error'
RUN echo '["linuxsys", "webssh", "nginx", "php-7.3", "mysql", "phpmyadmin"]' > /www/server/panel/config/index.json

VOLUME ["/www","/www/wwwroot"]

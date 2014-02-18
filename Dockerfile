FROM        skippy/base
MAINTAINER  Adam Greene <adam.greene@gmail.com>

# Basic requirements
RUN         apt-get -y install redis-server

# redis configs
RUN         echo 'vm.overcommit_memory=1' >> /etc/sysctl.d/60-redis.conf
RUN         sed -i -e "s/daemonize .\+/daemonize no/" /etc/redis/redis.conf
RUN         sed -i -e "s/dir .\+/dir \/data\/redis/" /etc/redis/redis.conf
RUN         sed -i -e "s/logfile .\+/logfile stdout/" /etc/redis/redis.conf
RUN         sed -i -e "s/appendonly .\+/appendonly yes/" /etc/redis/redis.conf

VOLUME      /data/redis

# Supervisor config
ADD         supervisord.conf /etc/supervisor/conf.d/redis.conf

# Expose Redis default ports
EXPOSE      6379

CMD         /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

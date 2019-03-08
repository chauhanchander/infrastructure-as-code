# Pull image. The ubuntu:latest tag points to the "latest LTS"
FROM ubuntu:latest

# Install Redis.
ENV TZ=Indian
ENV DEBIAN_FRONTEND=noninteractive
ENV MAXMEMORY=50000
RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone && \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y build-essential tcl && \
  apt-get install -y apt-utils && \
  apt-get install -y curl && \
  cd /tmp && \
  curl -O http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf && \ 
  echo "maxmemory ${MAXMEMORY}" >> /etc/redis/redis.conf && \
  echo "redis-server /etc/redis/redis.conf" > /etc/redis/setconfigommand.sh&& \
  echo "redis-cli config set maxmemory $MAXMEMORY" >> /etc/redis/setconfigcommand.sh 

   

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.

CMD ["redis-server", "/etc/redis/redis.conf"]

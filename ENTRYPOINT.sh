#!/bin/sh

set -x

WEB_ADDR=0.0.0.0:8080
REDIS_ADDR=redis:6379

# busuanzi js API address
if [ -n "$API_SERVER" ];then
  sed -i "s/http:\/\/0.0.0.0:8080\/api/$API_SERVER/g" dist/busuanzi.js
fi

# 监听地址
if [ -n "$WEB_ADDR" ];then
  sed -i "s/Address: 0.0.0.0:8080/Address: $WEB_ADDR/g" config/config.yaml
fi 

# redis地址
if [ -n "$REDIS_ADDR" ];then
  sed -i "s/Address: 127.0.0.1:6379/Address: $REDIS_ADDR/g" config/config.yaml
fi

# redis 密码
if [ -n "$REDIS_PWD" ];then
  sed -i "s/Password:/Password: $REDIS_PWD/g" config/config.yaml
fi 

# 是否开启debug模式
if [ -n "$DEBUG_ENABLE" ];then
  sed -i "s/Debug: true/Debug: $DEBUG_ENABLE/g" config/config.yaml
fi 

# 是否开启日志
if [ -n "$LOG_ENABLE" ];then
  sed -i "s/Log: true/Log: $LOG_ENABLE/g" config/config.yaml
fi 

# 统计数据过期时间 单位秒, 请输入整数 (无任何访问, 超过这个时间后, 统计数据将被清空, 0为不过期)
if [ -n "$EXPIRE_TIME" ];then
  sed -i "s/Expire: 2592000/Expire: $EXPIRE_TIME/g" config/config.yaml
fi

exec "$1 -c config/config.yaml"
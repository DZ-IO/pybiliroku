FROM python
LABEL maintainer="大泽IO <2592455724@qq.com>"
# 安装依赖
RUN apt update && apt install -y tzdata && \
    pip install aiohttp websockets addict psutil && \
    rm -rf /tmp/* /var/cache/* /var/log/* /var/mail/*
# 复制主程序
COPY ./ /app/
# 工作目录
WORKDIR /app
# 修复设置bug
RUN mkdir -p /data && \
    sed -i "s#streams/#/data/#g" manager.py && \
    sed -i "s#config\.json#/data/config\.json#g" manager.py
# 配置文件位置
VOLUME [ "/data" ]
# 端口
EXPOSE 2004
ENTRYPOINT [ "/usr/local/bin/python" ]
CMD [ "manager.py" ]

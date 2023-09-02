FROM python
LABEL maintainer="大泽IO <2592455724@qq.com>"
COPY ./ /app/
WORKDIR /app
RUN mkdir /app/streams/recoards && \
    apt update && apt install -y tzdata && \
    pip install aiohttp websockets addict psutil && \
    sed -i s#streams/#streams/recoards/#g manager.py && \
    rm -rf /tmp/* /var/cache/* /var/log/* /var/mail/*
EXPOSE 2004
VOLUME [ "/app/streams/recoards" ]
ENTRYPOINT [ "/usr/local/bin/python" ]
CMD [ "manager.py" ]

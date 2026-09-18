FROM alpine:latest

RUN apk add --no-cache curl unzip python3 py3-pip && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then XRAY_ARCH="64"; \
    elif [ "$ARCH" = "aarch64" ]; then XRAY_ARCH="arm64-v8a"; \
    else XRAY_ARCH="64"; fi && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${XRAY_ARCH}.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    rm /tmp/xray.zip

RUN pip3 install --no-cache-dir flask --break-system-packages

COPY config.json /etc/xray/config.json
COPY app.py /app.py

EXPOSE 8080

RUN echo '#!/bin/sh' > /start.sh && \
    echo 'xray -config /etc/xray/config.json &' >> /start.sh && \
    echo 'python3 /app.py' >> /start.sh && \
    chmod +x /start.sh

CMD ["/start.sh"]

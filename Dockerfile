FROM alpine:latest

# ដំឡើង dependencies, Python3, pip និង Xray-core
RUN apk add --no-cache curl unzip python3 py3-pip && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then XRAY_ARCH="64"; \
    elif [ "$ARCH" = "aarch64" ]; then XRAY_ARCH="arm64-v8a"; \
    else XRAY_ARCH="64"; fi && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${XRAY_ARCH}.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    rm /tmp/xray.zip

# ដំឡើង Flask សម្រាប់ Python Web App
RUN pip3 install --no-cache-dir flask --break-system-packages

# ចម្លងឯកសារ Config និង App ចូលក្នុង Container
COPY config.json /etc/xray/config.json
COPY app.py /app.py

# បើក Port ដែល Render ប្រើប្រាស់
EXPOSE 8080

# បង្កើត script ដើម្បីរត់ទាំង Xray និង Python Flask ພ້ອມគ្នា
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'xray -config /etc/xray/config.json &' >> /start.sh && \
    echo 'python3 /app.py' >> /start.sh && \
    chmod +x /start.sh

CMD ["/start.sh"]

FROM alpine:latest

# ដំឡើង dependencies ចាំបាច់ និង Xray
RUN apk add --no-cache curl unzip && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then XRAY_ARCH="64"; \
    elif [ "$ARCH" = "aarch64" ]; then XRAY_ARCH="arm64-v8a"; \
    else XRAY_ARCH="64"; fi && \
    curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${XRAY_ARCH}.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    rm /tmp/xray.zip

# ចម្លង config.json ចូលទៅក្នុង container
COPY config.json /etc/xray/config.json

# បើក Port តាមដែល Render កំណត់ (Render ប្រើប្រាស់ Environment Variable PORT)
EXPOSE 8080

# រត់សរសេរកម្មវិធី Xray
CMD ["xray", "-config", "/etc/xray/config.json"]

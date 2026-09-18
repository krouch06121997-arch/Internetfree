FROM alpine:latest

# ដំឡើង dependencies ចាំបាច់ទាំងអស់
RUN apk add --no-cache curl wget bash tzdata sqlite ca-certificates

# ទាញយក script install របស់ 3X-UI និងរៀបចំដំណើរការដោយឆ្លងកាត់ការសួរបញ្ជាក់ (auto-accept)
RUN wget -O /tmp/install.sh https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh && \
    chmod +x /tmp/install.sh && \
    yes | /tmp/install.sh && \
    rm /tmp/install.sh

# បើក Port សម្រាប់ Panel (Default: 2053) និង Port សម្រាប់ V2Ray
EXPOSE 2053 10000

# ដំណើរការ 3X-UI panel
CMD ["/usr/bin/xray-ui", "web"]

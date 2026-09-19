FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    bash \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# ទាញយក script មកទុក រួចប្រើប្រាស់ echo ដើម្បីឆ្លើយតបស្វ័យប្រវត្តិដោយសុវត្ថិភាព
RUN wget -O /tmp/install.sh https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh && \
    chmod +x /tmp/install.sh && \
    printf "y\ny\ny\ny\ny\n" | /tmp/install.sh && \
    rm /tmp/install.sh

EXPOSE 2053 10000

CMD ["/usr/bin/xray-ui", "web"]

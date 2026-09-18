FROM ubuntu:latest

# កុំឱ្យវាសួរផ្ទាំង interactive ពេលកំពុងដំឡើង
ENV DEBIAN_FRONTEND=noninteractive

# ដំឡើង dependencies ចាំបាច់នៅលើ Ubuntu
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    bash \
    tzdata \
    systemctl \
    && rm -rf /var/lib/apt/lists/*

# ទាញយក និងដំឡើង 3X-UI យ៉ាងរលូននៅលើ Ubuntu
RUN bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh) <<< "y"

# បើក Port សម្រាប់ Panel (2053) និង Port V2Ray (10000)
EXPOSE 2053 10000

# ដំណើរការ 3X-UI panel
CMD ["/usr/bin/xray-ui", "web"]

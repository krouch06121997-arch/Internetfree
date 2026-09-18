FROM alpine:latest

# ដំឡើង dependencies ចាំបាច់
RUN apk add --no-cache curl wget bash tzdata sqlite

# ទាញយក និងដំឡើង 3X-UI (Xray-ui Panel)
RUN wget -N https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh && \
    bash install.sh <<< "y"

# បើក Port សម្រាប់ Panel (Default: 2053) និង Port សម្រាប់ V2Ray (ឧទាហរណ៍: 10000)
EXPOSE 2053 10000

# ដំណើរការ 3X-UI panel
CMD ["/usr/bin/xray-ui", "web"]

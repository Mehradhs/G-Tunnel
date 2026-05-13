FROM debian:bookworm-slim

COPY install.sh /app/install.sh
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash git curl wget unzip tzdata openssl ca-certificates procps uuid-runtime \
    && rm -rf /var/lib/apt/lists/*

RUN chmod +x /app/install.sh && /app/install.sh
COPY config.json /etc/config.json

# دستور چاپ لینک اختصاصی برای کلاینت شما
RUN echo 'source /etc/start.sh' >> /etc/bash.bashrc
COPY start.sh /etc/start.sh
RUN chmod +x /etc/start.sh

CMD ["sleep", "infinity"]
FROM debian:stable-slim
COPY entrypoint.sh /entrypoint.sh
RUN apt-get update; \
    apt-get install -y zip; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

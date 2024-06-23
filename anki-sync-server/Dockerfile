FROM rust:1-bookworm AS builder
USER root
RUN set -eux; \
  apt-get update; \
  apt-get install -y protobuf-compiler
USER nobody
RUN ["cargo", "install", "--root", "/tmp", "--git", "https://github.com/ankitects/anki.git", "--tag", "24.06.2", "anki-sync-server"]

FROM debian:bookworm-slim
COPY --from=builder /tmp/bin/anki-sync-server /anki-sync-server
RUN set -eux; \
	groupadd -r anki-sync-server --gid=999; \
	useradd -r -g anki-sync-server --uid=999 --home-dir=/var/lib/anki-sync-server --shell=/bin/bash anki-sync-server; \
	mkdir -p /var/lib/anki-sync-server; \
	chown -R anki-sync-server:anki-sync-server /var/lib/anki-sync-server
USER anki-sync-server
ENV SYNC_BASE=/var/lib/anki-sync-server
EXPOSE 8080
ENTRYPOINT ["/anki-sync-server"]

FROM golang:1.20-alpine3.18 AS builder
RUN apk add --no-cache git ca-certificates mailcap
WORKDIR /app
COPY --chmod=755 ["build.sh", "/app"]
RUN ["/app/build.sh"]

FROM alpine:3.18
RUN apk add --no-cache ca-certificates mailcap
COPY --from=builder /app/smtp_to_telegram /smtp_to_telegram
USER daemon
ENV ST_SMTP_LISTEN="0.0.0.0:2525"
EXPOSE 2525
ENTRYPOINT ["/smtp_to_telegram"]
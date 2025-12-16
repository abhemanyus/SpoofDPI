FROM golang:alpine AS builder
WORKDIR /build
COPY . .
RUN go install -ldflags '-w -s -extldflags "-static"' -tags timetzdata ./cmd/spoofdpi

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/bin/spoofdpi /
ENTRYPOINT ["/spoofdpi"]

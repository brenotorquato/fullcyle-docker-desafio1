## Stage 1

FROM golang:1.21.6 as builder

RUN mkdir -p /app

WORKDIR /app

RUN go mod init feedme

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /app main.go

## Stage 2

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["/app/main"]
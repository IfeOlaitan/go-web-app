FROM golang:1.22.5 as build

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Final Stage - Using Distroless Image
FROM gcr.io/distroless/base

COPY --from=build /app/main .

COPY --from=build /app/static ./static

EXPOSE 8080

CMD ["./main"]

# Docker file
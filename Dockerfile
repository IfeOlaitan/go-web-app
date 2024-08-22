FROM golang:1.22.5 as build

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o main main.go

# Final Stage - Using Distroless Image
FROM gcr.io/distroless/base

COPY --from=build /app/main .

COPY --from=build /app/static ./static

EXPOSE 8080

CMD ["./main"]
# Golang Binary Build Stage
FROM golang:1.20.7-alpine as builder

# Set the working directory in the container
WORKDIR /app

# Copy the entire project to the container
COPY . .

# Build the Golang application
RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor -installsuffix cgo -o GoDockerSample
RUN ls -all && pwd

# Minimal Runtime Stage
FROM alpine:latest

# Copy the binary from the builder stage to the /GoDockerSample directory in the final stage
COPY --from=builder /app/GoDockerSample /GoDockerSample

# Set the default entry point for the container
ENTRYPOINT [ "/GoDockerSample" ]
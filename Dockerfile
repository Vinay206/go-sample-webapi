# Stage 1: Build the Go binary
FROM golang:1.20-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files to leverage caching of dependencies
COPY go.mod ./

# Download all dependencies. Caching these will speed up subsequent builds.
RUN go mod download

# Copy the entire Go application source code to the container
COPY . .

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Stage 2: Create a lightweight runtime environment
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the static files from the build stage
COPY --from=builder /app/main /app/
COPY --from=builder /app/static /app/static

# Expose port 80
EXPOSE 80

# Command to run the executable
ENTRYPOINT ["/app/main"]

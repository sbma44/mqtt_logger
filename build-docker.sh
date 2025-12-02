#!/bin/bash
# Build MQTT Logger Docker image with email alerts support

set -e

# Default values (can be overridden with environment variables)
SMTP_SERVER=${SMTP_SERVER:-""}
SMTP_PORT=${SMTP_PORT:-"587"}
SMTP_FROM=${SMTP_FROM:-""}
SMTP_TO=${SMTP_TO:-""}
SMTP_PASSWORD=${SMTP_PASSWORD:-""}

echo "Building MQTT Logger Docker image..."
echo "=================================="

if [ -n "$SMTP_SERVER" ]; then
    echo "Email alerts: ENABLED"
    echo "  SMTP Server: $SMTP_SERVER"
    echo "  SMTP Port: $SMTP_PORT"
    echo "  From: $SMTP_FROM"
    echo "  To: $SMTP_TO"
    echo ""

    docker build \
        --build-arg SMTP_SERVER="$SMTP_SERVER" \
        --build-arg SMTP_PORT="$SMTP_PORT" \
        --build-arg SMTP_FROM="$SMTP_FROM" \
        --build-arg SMTP_TO="$SMTP_TO" \
        --build-arg SMTP_PASSWORD="$SMTP_PASSWORD" \
        -t mqtt-logger:latest \
        .
else
    echo "Email alerts: DISABLED"
    echo "(Set SMTP_* environment variables to enable)"
    echo ""

    docker build -t mqtt-logger:latest .
fi

echo ""
echo "=================================="
echo "Build complete! Image: mqtt-logger:latest"
echo ""
echo "Run with:"
echo "  docker run -d --name mqtt-logger -v \$(pwd)/data:/app/data -e MQTT_BROKER=your-broker mqtt-logger:latest"
echo ""
echo "See DOCKER.md for full documentation"


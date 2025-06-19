#!/bin/bash

# Script to start nginx with the proxy configuration

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "Installing nginx..."
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Stop any existing nginx processes
sudo pkill nginx 2>/dev/null || true

# Start nginx with our custom configuration
echo "Starting nginx proxy servers..."
sudo nginx -c $(pwd)/nginx.conf -g "daemon off;" &

# Show the running processes
sleep 2
echo "Nginx proxy servers started:"
echo "- Hasura: http://localhost:8081 (or Codespaces equivalent)"
echo "- Auth: http://localhost:8082"
echo "- Storage: http://localhost:8083"
echo "- Dashboard: http://localhost:8084"
echo "- Functions: http://localhost:8085"
echo "- Mailhog: http://localhost:8086"

# Keep the script running
wait

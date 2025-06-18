#!/bin/bash

echo "🔧 Docker Socket Permission Fixer"
echo "================================="

# Check if Docker socket exists
if [ ! -S /var/run/docker.sock ]; then
    echo "❌ Docker socket not found at /var/run/docker.sock"
    echo "   Make sure Docker is installed and running."
    exit 1
fi

# Display current socket information
echo "📊 Current Docker socket information:"
ls -la /var/run/docker.sock
echo ""

# Get socket details
SOCKET_USER=$(stat -c '%U' /var/run/docker.sock)
SOCKET_GROUP=$(stat -c '%G' /var/run/docker.sock)
SOCKET_GID=$(stat -c '%g' /var/run/docker.sock)
SOCKET_PERMS=$(stat -c '%a' /var/run/docker.sock)

echo "   Owner: $SOCKET_USER"
echo "   Group: $SOCKET_GROUP (GID: $SOCKET_GID)"
echo "   Permissions: $SOCKET_PERMS"
echo ""

# Check current user groups
echo "👤 Current user information:"
echo "   User: $(whoami)"
echo "   Groups: $(groups)"
echo ""

# Test Docker access before fixing
echo "🧪 Testing Docker access..."
if docker ps >/dev/null 2>&1; then
    echo "✅ Docker is already accessible!"
    exit 0
else
    echo "❌ Docker access failed. Applying fixes..."
fi

# Get the docker group GID
DOCKER_GID=$(getent group docker | cut -d: -f3 2>/dev/null || echo "994")
echo "🔍 Docker group GID: $DOCKER_GID"

# Fix 1: Change socket group to docker
echo "🔧 Fix 1: Setting socket group to 'docker'..."
if sudo chgrp docker /var/run/docker.sock 2>/dev/null; then
    echo "   ✅ Socket group changed to docker"
else
    echo "   ⚠️  Failed to change socket group"
fi

# Fix 2: Set proper permissions
echo "🔧 Fix 2: Setting proper permissions..."
if sudo chmod g+rw /var/run/docker.sock 2>/dev/null; then
    echo "   ✅ Socket permissions updated"
else
    echo "   ⚠️  Failed to update socket permissions"
fi

# Test again
echo "🧪 Testing Docker access after fixes..."
if docker ps >/dev/null 2>&1; then
    echo "✅ Docker access successful!"
    echo ""
    echo "📊 Final Docker socket information:"
    ls -la /var/run/docker.sock
else
    echo "❌ Docker access still failing. Trying fallback fix..."
    
    # Fallback: make socket world-writable (less secure but functional)
    if sudo chmod 666 /var/run/docker.sock 2>/dev/null; then
        echo "   Applied fallback permissions (666)"
        
        if docker ps >/dev/null 2>&1; then
            echo "✅ Docker access successful with fallback permissions!"
            echo "⚠️  Note: Socket permissions are less secure (world-writable)"
        else
            echo "❌ Docker access still failing even with fallback permissions"
            echo "   Manual intervention required"
            exit 1
        fi
    else
        echo "❌ Failed to apply fallback permissions"
        exit 1
    fi
fi

echo ""
echo "🎉 Docker socket permissions fixed successfully!"

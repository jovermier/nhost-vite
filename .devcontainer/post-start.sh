#!/bin/bash

echo "🔄 Running post-start script..."

# Fix Docker socket permissions
echo "🔧 Fixing Docker socket permissions..."
if [ -S /var/run/docker.sock ]; then
    # Check current Docker socket ownership
    SOCKET_GROUP=$(stat -c '%G' /var/run/docker.sock 2>/dev/null || echo "unknown")
    SOCKET_GID=$(stat -c '%g' /var/run/docker.sock 2>/dev/null || echo "unknown")
    echo "   Docker socket group: $SOCKET_GROUP (GID: $SOCKET_GID)"
    
    # Get the docker group GID
    DOCKER_GID=$(getent group docker | cut -d: -f3 2>/dev/null || echo "994")
    echo "   Docker group GID: $DOCKER_GID"
    
    # If socket group doesn't match docker group, fix it
    if [ "$SOCKET_GID" != "$DOCKER_GID" ]; then
        echo "   Fixing Docker socket group ownership..."
        sudo chgrp docker /var/run/docker.sock 2>/dev/null || true
    fi
    
    # Ensure socket has proper permissions
    sudo chmod g+rw /var/run/docker.sock 2>/dev/null || true
    
    # Verify Docker access
    if docker ps >/dev/null 2>&1; then
        echo "✅ Docker socket permissions fixed and verified"
    else
        echo "⚠️  Docker socket permissions may still need attention"
        echo "   Attempting fallback permission fix..."
        # Fallback: make socket accessible to current user's groups
        sudo chmod 666 /var/run/docker.sock 2>/dev/null || true
        if docker ps >/dev/null 2>&1; then
            echo "✅ Docker access restored with fallback permissions"
        else
            echo "❌ Docker access still not working. Manual intervention may be required."
        fi
    fi
else
    echo "⚠️  Docker socket not found at /var/run/docker.sock"
fi

# Check if Nhost is already running
if ! pgrep -f "nhost" > /dev/null; then
    echo "🚀 Starting Nhost development server..."
    # Start Nhost in the background
    nohup nhost up > nhost.log 2>&1 &
    
    # Wait a bit for services to start
    echo "⏳ Waiting for Nhost services to start..."
    sleep 10
    
    # Check if services are running
    if curl -s http://localhost:1337/healthz > /dev/null; then
        echo "✅ Nhost backend is running on http://localhost:1337"
    else
        echo "⚠️  Nhost backend might still be starting up. Check nhost.log for details."
    fi
    
    if curl -s http://localhost:8080 > /dev/null; then
        echo "✅ Hasura Console is running on http://localhost:8080"
    else
        echo "⚠️  Hasura Console might still be starting up."
    fi
else
    echo "✅ Nhost is already running"
fi

echo "🎯 Ready to develop! Run 'pnpm dev' to start the React app."

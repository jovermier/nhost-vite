#!/bin/bash

echo "🔄 Running post-start script..."

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

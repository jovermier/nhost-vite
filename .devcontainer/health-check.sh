#!/bin/bash

echo "🔍 Checking Nhost React Apollo Dev Container Health..."
echo ""

# Check if we're in a dev container
if [ ! -z "$REMOTE_CONTAINERS" ] || [ ! -z "$CODESPACES" ]; then
    echo "✅ Running in dev container environment"
else
    echo "⚠️  Not running in a dev container"
fi

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js: $NODE_VERSION"
else
    echo "❌ Node.js not found"
fi

# Check pnpm
if command -v pnpm &> /dev/null; then
    PNPM_VERSION=$(pnpm --version)
    echo "✅ pnpm: v$PNPM_VERSION"
else
    echo "❌ pnpm not found"
fi

# Check Nhost CLI
if command -v nhost &> /dev/null; then
    NHOST_VERSION=$(nhost --version)
    echo "✅ Nhost CLI: $NHOST_VERSION"
else
    echo "❌ Nhost CLI not found"
fi

# Check if .env exists
if [ -f .env ]; then
    echo "✅ .env file exists"
else
    echo "⚠️  .env file not found - run 'cp .env.example .env'"
fi

# Check if .secrets exists
if [ -f .secrets ]; then
    echo "✅ .secrets file exists"
else
    echo "⚠️  .secrets file not found - may be required for certain configurations"
fi

# Check if node_modules exists
if [ -d node_modules ]; then
    echo "✅ Dependencies installed"
else
    echo "⚠️  Dependencies not installed - run 'pnpm install'"
fi

echo ""
echo "🌐 Checking services..."

# Check Nhost backend
if curl -s http://localhost:1337/healthz > /dev/null 2>&1; then
    echo "✅ Nhost backend (http://localhost:1337)"
else
    echo "❌ Nhost backend not responding - run 'nhost up'"
fi

# Check Hasura console
if curl -s http://localhost:8080 > /dev/null 2>&1; then
    echo "✅ Hasura Console (http://localhost:8080)"
else
    echo "❌ Hasura Console not responding"
fi

# Check if React dev server is running
if curl -s http://localhost:3000 > /dev/null 2>&1; then
    echo "✅ React dev server (http://localhost:3000)"
else
    echo "⚠️  React dev server not running - run 'pnpm dev'"
fi

echo ""
echo "🚀 Quick start commands:"
echo "  pnpm dev          # Start React development server"
echo "  pnpm codegen      # Generate GraphQL types"
echo "  nhost up          # Start Nhost services"
echo "  nhost logs        # View Nhost logs"

#!/bin/bash

echo "🚀 Running post-create script..."

# Ensure Homebrew environment is loaded
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Copy .env.example to .env if it doesn't exist
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        echo "📋 Creating .env file from .env.example..."
        cp .env.example .env
    else
        echo "⚠️  Warning: .env file not found and .env.example doesn't exist."
        echo "   Please create a .env file or check the project documentation."
    fi
fi

# Copy .secrets.example to .secrets if it doesn't exist
if [ ! -f .secrets ]; then
    if [ -f .secrets.example ]; then
        echo "🔐 Creating .secrets file from .secrets.example..."
        cp .secrets.example .secrets
    else
        echo "⚠️  Warning: .secrets file not found and .secrets.example doesn't exist."
        echo "   If you need a .secrets file, please create one or check the project documentation."
    fi
fi

# Verify pnpm is available
if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm not found in PATH. Installing pnpm via npm as fallback..."
    npm install -g pnpm
fi

# Install dependencies
echo "📦 Installing dependencies with pnpm..."
pnpm install

# Make scripts executable
chmod +x .devcontainer/post-start.sh

echo "✅ Post-create script completed!"

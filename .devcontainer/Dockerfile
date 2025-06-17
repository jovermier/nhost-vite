FROM mcr.microsoft.com/devcontainers/typescript-node

# Create node user with proper permissions (the default node image doesn't have a node user)
RUN groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node || true

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    build-essential \
    procps \
    file \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Add node user to sudoers
RUN echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install Docker CLI (for Docker-in-Docker)
RUN curl -fsSL https://get.docker.com | sh

# Switch to node user for homebrew installation
USER node

# Install Homebrew as the node user
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Set up Homebrew environment variables
ENV HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
ENV HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
ENV HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
ENV MANPATH="/home/linuxbrew/.linuxbrew/share/man:"
ENV INFOPATH="/home/linuxbrew/.linuxbrew/share/info:"

# Add homebrew to shell profile for persistent sessions
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile

# Install pnpm and other tools using Homebrew
RUN brew install pnpm nano gh tcptraceroute

# Switch back to root to install Nhost CLI system-wide
USER root

# Install Nhost CLI using the official installation script
RUN curl -L https://raw.githubusercontent.com/nhost/cli/main/get.sh | bash

# Set the default user back to node
USER node

# Create workspace directory
WORKDIR /workspace

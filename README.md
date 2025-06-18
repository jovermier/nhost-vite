# GraphQL Code Generator Example with React and Apollo Client

Todo app to show how to use:

- [Nhost](https://nhost.io/)
- [React](https://reactjs.org/)
- [TypeScript](https://www.typescriptlang.org/)
- [GraphQL Code Generator](https://the-guild.dev/graphql/codegen)
- [Apollo Client](https://www.apollographql.com/docs/react/)

This repo is a reference repo for the blog post: [How to use GraphQL Code Generator with React and Apollo](https://nhost.io/blog/how-to-use-graphql-code-generator-with-react-and-apollo).

## Get Started with Dev Container

The easiest way to get started is using a dev container that automatically sets up and configures all services:

### Prerequisites

- **Docker**: [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommended) or Docker Engine on Linux
  - **Linux users**: Docker Engine is sufficient - Docker Desktop is not required
  - **macOS/Windows**: Docker Desktop provides the easiest setup, but alternatives like [Colima](https://github.com/abiosoft/colima) (macOS) or [Podman](https://podman.io/) can also work
- **IDE with Dev Container support**:
  - [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
  - [Cursor](https://cursor.sh/) (supports dev containers natively)
  - [JetBrains IDEs](https://www.jetbrains.com/help/idea/connect-to-devcontainer.html) (IntelliJ IDEA, WebStorm, etc.)
  - Or any IDE that supports the [Dev Container specification](https://containers.dev/)

### Setup

1. **Open in Dev Container**:

   - **VS Code/Cursor**: Open this folder and click "Reopen in Container" when prompted (or use Command Palette: "Dev Containers: Reopen in Container")
   - **JetBrains IDEs**: Use "Remote Development" → "Dev Containers"
   - Wait for the container to build and all services to start automatically

2. **Automatic Setup**: The dev container automatically:

   - Installs all dependencies (pnpm, Node.js, Nhost CLI)
   - Copies environment variables from `.env.example` to `.env`
   - Starts Nhost services in the background
   - Configures port forwarding for all services

3. **Start the React Application**:
   ```sh
   pnpm dev
   ```

That's it! The dev container automatically handles:

- Installing all dependencies
- Setting up environment variables
- Starting Nhost services in the background
- Configuring proper port forwarding and routing

## Available Services

When the dev container is running, the following services will be automatically available:

- **React App**: http://localhost:3000
- **Nhost Backend**: http://localhost:1337
- **Hasura Console**: http://localhost:8080
- **Mailhog (Email Testing)**: http://localhost:8025
- **Grafana (Monitoring)**: http://localhost:9000
- **PostgreSQL Database**: localhost:5432

All services are properly configured and routed through the dev container's network.

## Using Nhost Subdomain for External Access

The dev container is configured to work with Nhost's subdomain feature for external access (e.g., mobile testing). The default configuration uses `local` subdomain for development within the container.

If you need external access to your development environment from devices on your network:

1. **Find Your IP Address**:

   ```bash
   hostname -I | awk '{print $1}'
   ```

2. **Update Environment Variables**:
   Edit your `.env` file to use external configuration:

   ```bash
   # Replace with your IP address using dashes instead of dots
   VITE_NHOST_SUBDOMAIN = 192-168-1-103-proj-a
   VITE_NHOST_REGION = local
   ```

3. **Restart Nhost with Subdomain**:

   ```bash
   nhost down
   nhost up --local-subdomain 192-168-1-103-proj-a
   ```

4. **Restart Your React App**:
   ```bash
   pnpm dev
   ```

Your Nhost services will then be accessible from external devices using the subdomain URLs, while the React app remains accessible at your host machine's IP address on port 3000.

## GraphQL Code Generator

To re-run the GraphQL Code Generator:

```bash
pnpm codegen
```

## Troubleshooting

### Check Container Health

```bash
pnpm health
```

### View Nhost Logs

```bash
nhost logs
```

### Restart Services

```bash
nhost down
nhost up
```

# GraphQL Code Generator Example with React and Apollo Client

Todo app to show how to use:

- [Nhost](https://nhost.io/)
- [React](https://reactjs.org/)
- [TypeScript](https://www.typescriptlang.org/)
- [GraphQL Code Generator](https://the-guild.dev/graphql/codegen)
- [Apollo Client](https://www.apollographql.com/docs/react/)

This repo is a reference repo for the blog post: [How to use GraphQL Code Generator with React and Apollo](https://nhost.io/blog/how-to-use-graphql-code-generator-with-react-and-apollo).

## Get Started

### Option 1: Dev Container (Recommended)

The easiest way to get started is using a dev container:

1. **Prerequisites**:

   - **Docker**: [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommended) or Docker Engine on Linux
     - **Linux users**: Docker Engine is sufficient - Docker Desktop is not required
     - **macOS/Windows**: Docker Desktop provides the easiest setup, but alternatives like [Colima](https://github.com/abiosoft/colima) (macOS) or [Podman](https://podman.io/) can also work
   - **IDE with Dev Container support**:
     - [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
     - [Cursor](https://cursor.sh/) (supports dev containers natively)
     - [JetBrains IDEs](https://www.jetbrains.com/help/idea/connect-to-devcontainer.html) (IntelliJ IDEA, WebStorm, etc.)
     - Or any IDE that supports the [Dev Container specification](https://containers.dev/)

2. **Open in Dev Container**:

   - **VS Code/Cursor**: Open this folder and click "Reopen in Container" when prompted (or use Command Palette: "Dev Containers: Reopen in Container")
   - **JetBrains IDEs**: Use "Remote Development" → "Dev Containers"
   - **Command Line**: You can also run the dev container directly with Docker:
     ```bash
     docker build -t nhost-react-apollo .devcontainer
     docker run -it -p 3000:3000 -p 1337:1337 -p 8080:8080 -v $(pwd):/workspace nhost-react-apollo
     ```
   - Wait for the container to build and services to start automatically

3. **Start Development**:

   ```sh
   pnpm dev
   ```

### Option 2: Manual Setup

1. Clone the repository

```sh
git clone https://github.com/nhost/nhost
cd nhost
```

2. Install and build dependencies

```sh
pnpm install
pnpm run build
```

3. Go to the example folder

```sh
cd examples/codegen-react-apollo
```

4. Copy environment variables

```sh
cp .env.example .env
```

5. Terminal 1: Start Nhost

```sh
nhost up
```

6. Terminal 2: Start the React application

```sh
pnpm dev
```

## Services

When running (either in dev container or manually), the following services will be available:

- **React App**: http://localhost:3000
- **Nhost Backend**: http://localhost:1337
- **Hasura Console**: http://localhost:8080
- **Mailhog (Email Testing)**: http://localhost:8025
- **Grafana (Monitoring)**: http://localhost:9000

## External Access (Mobile Testing)

To access your Nhost development environment from external devices (like phones on the same network), you can manually configure the `--local-subdomain` feature:

### Manual Setup

#### Step 1: Find Your IP Address

```bash
# On Linux/macOS
hostname -I | awk '{print $1}'
# or
ip route get 1.2.3.4 | awk '{print $7}'

# On Windows
ipconfig | findstr IPv4
```

#### Step 2: Start Nhost with Local Subdomain

Replace `192.168.1.103` with your actual IP address, using dashes instead of dots:

```bash
nhost up --local-subdomain 192-168-1-103-proj-a
```

#### Step 3: Update Environment Variables

Update your `.env` file to use the external subdomain:

```bash
# Comment out local configuration
# VITE_NHOST_SUBDOMAIN = local
# VITE_NHOST_REGION = local

# Use external configuration
VITE_NHOST_SUBDOMAIN = 192-168-1-103-proj-a
VITE_NHOST_REGION = local
```

#### Step 4: Restart Your App

```bash
pnpm dev
```

#### Step 5: Access from External Devices

Your services will now be accessible from any device on the network using these URLs:

- **React App**: http://192.168.1.103:3000 (replace with your IP)
- **Hasura Console**: https://192-168-1-103-proj-a.hasura.local.nhost.run
- **GraphQL Endpoint**: https://192-168-1-103-proj-a.graphql.local.nhost.run
- **Auth Service**: https://192-168-1-103-proj-a.auth.local.nhost.run
- **Storage Service**: https://192-168-1-103-proj-a.storage.local.nhost.run
- **Mailhog**: https://192-168-1-103-proj-a.mailhog.local.nhost.run
- **Dashboard**: https://192-168-1-103-proj-a.dashboard.local.nhost.run

### Switching Back to Local Development

To revert to local-only development, manually update `.env`:

```bash
VITE_NHOST_SUBDOMAIN = local
VITE_NHOST_REGION = local
```

Then restart Nhost:

```bash
nhost down
nhost up
```

## GraphQL Code Generator

To re-run the GraphQL Code Generator, run the following:

```bash
pnpm codegen
```

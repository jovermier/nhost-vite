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

The easiest way to get started is using VS Code Dev Containers:

1. **Prerequisites**:

   - [VS Code](https://code.visualstudio.com/)
   - [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   - [Docker Desktop](https://www.docker.com/products/docker-desktop/)

2. **Open in Dev Container**:

   - Open this folder in VS Code
   - Click "Reopen in Container" when prompted (or use Command Palette: "Dev Containers: Reopen in Container")
   - Wait for the container to build and services to start automatically

3. **Start Development**:

   ```sh
   pnpm dev
   ```

4. **Health Check** (optional):
   ```sh
   pnpm health
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
pnpm run dev
```

## Services

When running (either in dev container or manually), the following services will be available:

- **React App**: http://localhost:3000
- **Nhost Backend**: http://localhost:1337
- **Hasura Console**: http://localhost:8080
- **Mailhog (Email Testing)**: http://localhost:8025
- **Grafana (Monitoring)**: http://localhost:9000

## GraphQL Code Generators

To re-run the GraphQL Code Generators, run the following:

```
pnpm codegen -w
```

> `-w` runs [codegen in watch mode](https://www.the-guild.dev/graphql/codegen/docs/getting-started/development-workflow#watch-mode).

# Dev Container Setup

This project is configured to work with VS Code Dev Containers, providing a consistent development environment with all necessary tools and services.

## Prerequisites

- [VS Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Getting Started

1. **Open in Dev Container**:

   - Open VS Code
   - Open the project folder
   - When prompted, click "Reopen in Container" or use the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and select "Dev Containers: Reopen in Container"

2. **Automatic Setup**:

   - The container will automatically build and install all dependencies
   - Nhost services will start automatically
   - Environment variables will be copied from `.env.example` to `.env`

3. **Start Development**:
   ```bash
   pnpm dev
   ```

## Available Services

The dev container automatically forwards the following ports:

- **3000**: React development server
- **1337**: Nhost backend API
- **8080**: Hasura GraphQL Console
- **5432**: PostgreSQL database
- **8025**: Mailhog web interface (email testing)
- **1025**: Mailhog SMTP server
- **3001**: Nhost Dashboard
- **4000**: Nhost Auth service
- **9000**: Grafana (monitoring)
- **9090**: Prometheus (metrics)
- **9093**: Alertmanager

## Useful Commands

- `pnpm dev` - Start the React development server
- `pnpm codegen` - Generate GraphQL types and hooks
- `nhost up` - Start Nhost services (runs automatically)
- `nhost down` - Stop Nhost services
- `nhost logs` - View Nhost service logs

## GraphQL Development

1. The Hasura Console is available at http://localhost:8080
2. Run `pnpm codegen` to generate TypeScript types and Apollo hooks
3. The generated code will be in `src/gql/`

## Database Management

- Access PostgreSQL directly on port 5432
- Use the Hasura Console for schema management
- Migrations are stored in `nhost/migrations/`

## Troubleshooting

1. **Services not starting**: Check `nhost.log` for error messages
2. **Port conflicts**: Ensure no other services are running on the forwarded ports
3. **Permission issues**: The container runs as the `node` user with proper permissions

## Environment Variables

The following environment variables are configured in `.env`:

- `VITE_NHOST_SUBDOMAIN=local` - Nhost subdomain for local development
- `VITE_NHOST_REGION=` - Leave empty for local development
- `HASURA_GRAPHQL_ADMIN_SECRET` - Admin secret for Hasura
- `HASURA_GRAPHQL_JWT_SECRET` - JWT secret for authentication
- `NHOST_WEBHOOK_SECRET` - Webhook secret for Nhost services

## VS Code Extensions

The dev container includes these helpful extensions:

- TypeScript support
- Tailwind CSS IntelliSense
- Prettier code formatting
- ESLint linting
- GraphQL syntax highlighting and IntelliSense

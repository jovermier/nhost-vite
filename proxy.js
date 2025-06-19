const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

// Helper to create a proxy server for a service
function createServiceProxy({ port, target, hostLabel, label }) {
  const app = express();
  app.use('/', createProxyMiddleware({
    target,
    changeOrigin: true,
    secure: false,
    onProxyReq: (proxyReq) => {
      proxyReq.setHeader('host', hostLabel);
    }
  }));
  app.listen(port, () => {
    console.log(`${label} proxy running on http://localhost:${port}`);
  });
}

createServiceProxy({
  port: process.env.HASURA_PROXY_PORT || 8081,
  target: 'https://local.hasura.local.nhost.run',
  hostLabel: 'local.hasura.local.nhost.run',
  label: 'Hasura'
});

createServiceProxy({
  port: process.env.AUTH_PROXY_PORT || 8082,
  target: 'https://local.auth.local.nhost.run',
  hostLabel: 'local.auth.local.nhost.run',
  label: 'Auth'
});

createServiceProxy({
  port: process.env.STORAGE_PROXY_PORT || 8083,
  target: 'https://local.storage.local.nhost.run',
  hostLabel: 'local.storage.local.nhost.run',
  label: 'Storage'
});

createServiceProxy({
  port: process.env.DASHBOARD_PROXY_PORT || 8084,
  target: 'https://local.dashboard.local.nhost.run',
  hostLabel: 'local.dashboard.local.nhost.run',
  label: 'Dashboard'
});

createServiceProxy({
  port: process.env.FUNCTIONS_PROXY_PORT || 8085,
  target: 'https://local.functions.local.nhost.run',
  hostLabel: 'local.functions.local.nhost.run',
  label: 'Functions'
});

createServiceProxy({
  port: process.env.MAILHOG_PROXY_PORT || 8086,
  target: 'https://local.mailhog.local.nhost.run',
  hostLabel: 'local.mailhog.local.nhost.run',
  label: 'Mailhog'
});

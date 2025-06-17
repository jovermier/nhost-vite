import { type CodegenConfig } from "@graphql-codegen/cli";
import { NhostClient } from "@nhost/nhost-js";

const nhost = new NhostClient({
  subdomain: process.env.NHOST_SUBDOMAIN ?? "local",
  region: process.env.NHOST_REGION,
  start: false,
  autoRefreshToken: false,
});

const graphqlUrl = nhost.graphql.httpUrl;

const config: CodegenConfig = {
  schema: [
    {
      [`${graphqlUrl}`]: {
        headers: {
          "x-hasura-admin-secret": `${process.env.HASURA_GRAPHQL_ADMIN_SECRET}`,
        },
      },
    },
  ],
  ignoreNoDocuments: true, // for better experience with the watcher
  generates: {
    "./src/gql/": {
      documents: ["src/**/*.tsx"],
      preset: "client",
      plugins: [],
    },
  },
};

export default config;

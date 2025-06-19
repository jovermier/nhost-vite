#!/bin/bash

nhost up \
  --disable-tls \
  --hasura-port 8086 \
  --hasura-console-port 8081 \
  --auth-port 8082 \
  --storage-port 8083 \
  --functions-port 8085
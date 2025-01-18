#!/usr/bin/env bash

image=$(docker inspect nginx | jq -e ".[0].Config.Image" || echo "error")

[[ ${image} == "\"nginx:1.27.3-alpine\"" ]]

# Probando si esta bien configurado el container:

curl -H "User-Agent: testing-scenario" http://localhost:8080


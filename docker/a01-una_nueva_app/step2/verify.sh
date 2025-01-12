#!/usr/bin/env bash

image=$(docker inspect app | jq -e ".[0].Config.Image" || echo "error")

[[ ${image} == "\"quinont/resistrining:ej1\"" ]]

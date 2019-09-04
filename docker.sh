#!/usr/bin/env bash

set -Eeo pipefail

docker build --tag covr .

docker run \
  --env-file env.list \
  --interactive \
  --rm \
  --tty \
  --volume $PWD:/covr \
  --volume $HOME/.ssh:/root/.ssh:ro \
  --volume $HOME/.kube:/root/.kube \
  covr "$@"

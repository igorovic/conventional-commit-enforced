#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"
. "$(dirname -- "$0")/common.sh"
echo "parepare-commit-msg hook"
# `CI` env variable should exists in most CI/CD environments
if [[ -z "${CI}" ]]; then
  # only run in non CI environments - e.g: dev machine
  exec < /dev/tty && node_modules/.bin/cz --hook || true
fi


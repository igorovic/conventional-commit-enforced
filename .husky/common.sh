#!/usr/bin/env sh
command_exists () {
  command -v "$1" >/dev/null 2>&1
}
# Workaround for Windows 10, Git Bash and Yarn
# to avoid errors when using /dev/tty in hooks
if command_exists winpty && test -t 1; then
  exec < /dev/tty
fi
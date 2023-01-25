# Conventional commits enforced

Example repo with conventional commits enforced

## Setp-by-step setup

```bash
pnpm add -D  husky commitizen @commitlint/cli @commitlint/cz-commitlint @commitlint/config-conventional
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
pnpm husky install
npm pkg set scripts.prepare="husky install"
pnpm commitizen init @commitlint/cz-commitlint --pnpm --save-dev --save-exact
```

### configure git hooks with husky

**with powershell**

```powershell
@'
command_exists () {
  command -v "$1" >/dev/null 2>&1
}

# Workaround for Windows 10, Git Bash and Yarn
# to avoid errors when using /dev/tty in hooks
if command_exists winpty && test -t 1; then
  exec < /dev/tty
fi
'@ | pnpm husky add .husky/common.sh
```

```powershell
@'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"
. "$(dirname -- "$0")/common.sh"

# `CI` env variable should exists in most CI/CD environments
if [[ -z "${CI}" ]]; then
  # only run in non CI environments - e.g: dev machine
  exec < /dev/tty && node_modules/.bin/cz --hook || true
fi
'@ | pnpm husky add .husky/prepare-commit-msg.sh
```

**with bash**

```bash
cat <<EOF | pnpm husky add .husky/common.sh
command_exists () {
  command -v "\$1" >/dev/null 2>&1
}

# Workaround for Windows 10, Git Bash and Yarn
# to avoid errors when using /dev/tty in hooks
if command_exists winpty && test -t 1; then
  exec < /dev/tty
fi
EOF
```

```bash
cat <<EOF | pnpm husky add .husky/prepare-commit-msg.sh
#!/usr/bin/env sh
. "\$(dirname -- "\$0")/_/husky.sh"
. "\$(dirname -- "\$0")/common.sh"

# `CI` env variable should exists in most CI/CD environments
if [[ -z "\${CI}" ]]; then
  # only run in non CI environments - e.g: dev machine
  exec < /dev/tty && node_modules/.bin/cz --hook || true
fi
EOF
```

### Optional - install VScode commitizen extension

- [commitizen](https://marketplace.visualstudio.com/items?itemName=KnisterPeter.vscode-commitizen)

## Relevant config files

- `.husky/common.sh`
- `.husky/prepare-commit-msg.sh`
- `commitlint.config.js`
- `package.json` -> `config.commitizen.path`

## Test it

Try a commit

```
git add -A
git commit
```

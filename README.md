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

**.husky/common.sh**

```sh
#!/usr/bin/env sh
command_exists () {
  command -v "$1" >/dev/null 2>&1
}
# Workaround for Windows 10, Git Bash and Yarn
# to avoid errors when using /dev/tty in hooks
if command_exists winpty && test -t 1; then
  exec < /dev/tty
fi
```

**.husky/prepare-commit-msg**

```sh
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"
case `uname` in
    *CYGWIN*|*MINGW*|*MSYS*)
        . "$(dirname -- "$0")/common.sh"
        exit 0
    ;;
esac
exec < /dev/tty && node_modules/.bin/cz --hook || true
```

**.husky/commit-msg**

```sh
#!/usr/bin/env sh
. "$(dirname -- "$0")/common.sh"
case `uname` in
    *CYGWIN*|*MINGW*|*MSYS*)
        npx commitlint --edit
        exit 0
    exit 1;;
esac
```

#### set hook code in one command

```powershell
@'
__FILE_CONTENT__
'@ | pnpm husky add .husky/__GIT_HOOK_NAME__
```

**with bash**

```bash
cat <<EOF | pnpm husky add .husky/__GIT_HOOK_NAME__
__FILE_CONTENT__
EOF
```

### Make hooks executables

- ! This step is required for Mac OS and Linux users

```bash
chmod +x .husky/common.sh
chmod +x .husky/prepare-commit-msg
chmod +x .husky/commit-msg
```

### Optional - install VScode commitizen extension

- [commitizen](https://marketplace.visualstudio.com/items?itemName=KnisterPeter.vscode-commitizen)

## Relevant config files

- `.husky/common.sh`
- `.husky/prepare-commit-msg`
- `.husky/commit-msg`
- `commitlint.config.js`
- `package.json` -> `config.commitizen.path`

## Result

- You can still use `git` to create a commit. But after submitting your commit message `commitlint` kicks in and prevents commiting unconventional message.
  - If you commit from vscode you get the same behavior.
- If you are on MacOS or Linux it will start commitizen interactive prompt

## Test it

Try a commit

```
git add -A
git commit
```

# User Preferences

## Code Style

- Prefer single quotes over double quotes in Python

## Git Commit

- Keep commit messages concise (1-liner)
- Do not include `Co-Authored-By` or similar trailers

## CLI

### Azure CLI

- `az`: For interacting with Azure services (e.g., Azure DevOps, Azure ML).
  [CLI Reference](https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)

### Preferred Modern Alternatives

Use these instead of their traditional counterparts:

| Traditional | Preferred Alternative          |
| ----------- | ------------------------------ |
| `grep`      | `rg` (ripgrep)                 |
| `find`      | `fd`                           |

### Additional Preferred Tools

| Tool  | Purpose                        |
| ----- | ------------------------------ |
| `fzf` | Fuzzy finder                   |
| `jq`  | JSON processor                 |
| `yq`  | YAML/XML/TOML processor        |

### Command Output

- Avoid piping command output to `| head`, `| tail`, etc. so the user can see progress in real time

## Background Tasks

- When running a background task, report progress in 30s–120s intervals depending on needs
- When waiting for anything (builds, downloads, pipelines), always wait in background — never block the conversation

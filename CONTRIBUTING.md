# Contributing

Bug fixes and improvements to the Ansible code are welcome. The software installed by default follows the maintainer's personal
preferences: a role for software the maintainer does not use is accepted, but it must be disabled by default. **Open an issue
before a pull request** to agree on what to add, so no work is wasted.

Read [`AGENTS.md`](AGENTS.md) for the Ansible rules a change must follow; they apply equally to human and AI-assisted
contributions.

## Setup

Install [`pre-commit`](https://pre-commit.com/) and [`shellcheck`](https://www.shellcheck.net/) (`brew install pre-commit shellcheck`), then install the
hooks once with `make pre-commit-install`. It installs both the `pre-commit` and the `commit-msg` hooks, so commit messages are
checked when you commit.

- `make check` runs the full pre-commit suite on every file, `make check-stage` on the staged files only. It also regenerates
  `inventory/group_vars/all.yaml` from the role defaults.
- `make ansible-syntax-check` checks the syntax of every playbook, with the collections from `requirements.yml` installed into
  `.galaxy/`. It contacts no host.

Test a change that alters what the playbook does on a throwaway macOS virtual machine, never on the machine you work on.

## Commit messages

All commits must follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) with a scope:
`<type>(<scope>)[!]: <description>`. Use the role or playbook name as the scope. The `conventional-pre-commit` hook enforces this
on `commit-msg`, and the `conventional-commits` CI job checks it again on every pull request.

```text
fix(keyboard): keep Ctrl+C mapped in the terminal
feat(obs): add an OBS Studio role
feat(common)!: drop macOS 15 support
```

The release version is derived from these types, since the last release:

| Release | Commit | Example |
| --- | --- | --- |
| major | any type with `!` before the colon, or a `BREAKING CHANGE:` footer | `feat(common)!: drop macOS 15 support` |
| minor | `feat` | `feat(obs): add an OBS Studio role` |
| patch | `fix` | `fix(keyboard): keep Ctrl+C mapped in the terminal` |
| none | everything else: `build`, `chore`, `ci`, `docs`, `perf`, `refactor`, `style`, `test`, `revert` | `docs(readme): fix a link` |

Pick the type by whether the change should ship, not by what kind of change it is: a refactor or a revert that changes what the
playbook does is a `fix`. Every commit of a pull request lands on `master` as it is, so each one needs a correct type, not just the
pull request as a whole.

## Releasing

Dispatch the **Release** workflow from `master`. Leave the version empty to derive it from the commits, or pass one; tick *dry
run* first to see what it would do. It calls
[`simple-tag-and-release`](https://github.com/leinardi/gh-reusable-workflows/blob/main/.github/workflows/simple-tag-and-release.md),
which tags the release, creates the GitHub release with notes listing the merged pull requests, and moves the `vMAJOR` and
`latest` tags.

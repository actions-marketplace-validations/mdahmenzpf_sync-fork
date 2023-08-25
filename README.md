# Sync Fork Action

Sync changes from upstream into fork.

## Usage

First, make sure that the `GITHUB_TOKEN` has write access to your repository.
Write access can be enabled in the repository settings.
Then, add a workflow file with the following content to your fork.

```yaml
name: Sync Fork

on:
  schedule:
    - cron: "0 2 * * *"
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Sync
        uses: mdahmenzpf/sync-fork@master
        with:
          upstream: "https://github.com/public/repository.git"
          branches: "master develop"
          token: ${{ secrets.GITHUB_TOKEN }}
```

## Synching a Private Upstream Repository

In order to be able to sync a fork the was created from a private repository, the workflow also requires read
access to that upstream repository. In that case, the `GITHUB_TOKEN` can't be used and a
[personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
has to be created, stored safely as a
[repository secret](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#keeping-your-personal-access-tokens-secure)
and used instead of the default `GITHUB_TOKEN`.

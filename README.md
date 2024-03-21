# PR-listing
This will list all the closed PRs which are merged to the branch. You can give the name of base branch as the input. Below is the example of how you can use this in your repository.

# Example
```yaml
name: List-PRs
on:
  push:
    branches:
      - master
      - develop
jobs:
  job_name:
    name: List All PRs
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      - name: List PR
        uses: ShivamHS/PR-listing@v0.0.0
        with:
          repo_token: ${{ github.token }}
          owner: ${{github.owner}}
          repo_name: ${{github.repository}}
          base_branch: main

# package-action

## Features

GitHub Action for packaging repository.

## Usage

### Output arguments

|Arguments |Contents             |Required |default |
|:--:|:--:|:--:|:--:|
|RELEASE   |Filename for release |Required |release |
|EXCLUDES  |Excluded files       |Optional |.git    |

## Example

```yaml:.github/workflows/ubuntu-test.yml
name: "ubuntu-test"

on:
  push:
    tags:
      - "v*"

jobs:
  test_job:
    runs-on: ubuntu-latest
    name: "demo"
    steps:
      - name: "Set up Git repository"
        uses: actions/checkout@v2

      - name: "info-action"
        id: info_action
        uses: k5-mot/info-action@main

      - name: "package-action"
        id: package_action
        uses: k5-mot/package-action@main
        with: 
          RELEASE:  "${{ steps.info_action.outputs.release }}"
          EXCLUDES: ".git .vscode build release"
```

## References

* [Docker コンテナのアクションを作成する](https://docs.github.com/ja/actions/creating-actions/creating-a-docker-container-action)
* [GitHub Actionsのワークフローコマンド](https://docs.github.com/ja/actions/reference/workflow-commands-for-github-actions)
* [GitHub Actions のコンテキストおよび式の構文](https://docs.github.com/ja/actions/reference/context-and-expression-syntax-for-github-actions)
* [複合実行ステップ アクションの作成](https://docs.github.com/ja/actions/creating-actions/creating-a-composite-run-steps-action)
* [Docker Hub texlive/texlive](https://hub.docker.com/r/texlive/texlive/)

## Note

Good luck!!!

## Author

* k5-mot

## License

Copyright (c) 2021 k5-mot All Rights Reserved.

"k5-mot/latexmk-action" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).


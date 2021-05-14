# package-action

## Features

GitHub Action for packaging repository.

## Usage

### Output arguments

|Arguments  |Contents             |Required |default |
|:--:|:--:|:--:|:--:|
|RELEASE    |Filename for release |Required |release |
|EXCLUSIONS |Excluded files       |Optional |.git    |

## Example

```yaml:.github/workflows/ubuntu-test.yml
name: 'ubuntu-test'

on:
  push:
    tags:
      - 'v*'

jobs:
  test_job:
    runs-on: ubuntu-latest
    name: 'demo'
    steps:
      - name: 'Set up Git repository'
        uses: actions/checkout@v2

      - name: 'info-action'
        id: info_action
        uses: k5-mot/info-action@main

      - name: 'package-action'
        id: package_action
        uses: k5-mot/package-action@main
        with: 
          RELEASE:  'release'
          EXCLUSIONS: '.git .vscode build' 
          
      - name: 'Create Release'
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: ${{ github.ref }}
          body: |
            ${{ steps.info_action.outputs.version }}
          draft: false
          prerelease: false
    
      - name: 'Upload Release.tar.gz'
        id: upload_release_tar
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: release/release.tar.gz
          asset_name: ${{ steps.info_action.outputs.release }}.tar.gz
          asset_content_type: application/gzip

      - name: 'Upload Release.zip'
        id: upload_release_zip
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: release/release.zip
          asset_name: ${{ steps.info_action.outputs.release }}.zip
          asset_content_type: application/zip

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


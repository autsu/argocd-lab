# Jsonnet库目录

该目录用于存放Jsonnet库文件。在实际使用中，您需要下载或创建相应的库文件。

例如，您可以使用以下命令下载ksonnet-util库：

```bash
mkdir -p vendor/jsonnet-libs
git clone https://github.com/grafana/jsonnet-libs.git vendor/jsonnet-libs-temp
cp -r vendor/jsonnet-libs-temp/ksonnet-util vendor/jsonnet-libs/
rm -rf vendor/jsonnet-libs-temp
```

## 概要
zip圧縮したLambdaのソースをダウンロードするツールです。

## 前提条件
* AWS CLIのインストール
* Python3.xのインストール

## 構成
```
output/              : ダウンロード先
  {実行日時}/         : 実行日時
    {メトリクス名}/   : メトリクス名
lambda_list_get.py   : 起動ファイル
```

## 使用方法
python3 lambda_list_get

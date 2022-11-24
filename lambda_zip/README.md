## 概要
ローカルの各Lambda資材をzip形式に圧縮します。

## 前提条件
* 7zipのインストール（インストール先が以下でない場合は書き換えること）
```
@set ZIP_EXE="C:\Program Files\7-Zip\7z.exe"
```

## 構成
```
output/              : 出力先
  {実行日時}          : 実行日時
resouce_create.bat   : 起動バッチ
```

## 使用方法
resouce_create.bat "C:\work\01_job\codecommit\eg-iot-lambda\"
* %1:Lambda資材のディレクトリ

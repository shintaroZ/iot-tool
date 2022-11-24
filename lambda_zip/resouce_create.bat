@echo off
@setlocal enabledelayedexpansion

@set YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
@set HHMMSS=%time:~0,2%%time:~3,2%%time:~6,2%

@rem 資材の場所
@set TARGET_DIR=%1
@set BEFORE_CD=%cd%
@set ZIP_EXE="C:\Program Files\7-Zip\7z.exe"


@rem 出力先ディレクトリ
@set outputDir=%BEFORE_CD%\output\%YYYYMMDD%%HHMMSS%
echo 出力先： %outputDir%
mkdir %outputDir%

@rem ログ
@set logPath=%BEFORE_CD%\output\%YYYYMMDD%%HHMMSS%\log_%YYYYMMDD%%HHMMSS%.log

echo =============================================
@rem 資材分ループ
for /d %%I in (%TARGET_DIR%*) do (
  set targetPath=%%I
  set dirName=!targetPath:%TARGET_DIR%=!
  cd %%I
  if !dirName! == layer (
    @rem layerの場合は、python名でzip
    set dirName=python
  ) 
  echo !dirName!の資材を圧縮します。
  
  call %ZIP_EXE% a !dirName!.zip   >> %logPath%
  move !dirName!.zip %outputDir%   >> %logPath%
)
echo =============================================

echo 完了しました。何かキーを押下すると終了します。
pause > NUL

cd %BEFORE_CD%
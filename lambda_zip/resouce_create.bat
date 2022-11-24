@echo off
@setlocal enabledelayedexpansion

@set YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
@set HHMMSS=%time:~0,2%%time:~3,2%%time:~6,2%

@rem ���ނ̏ꏊ
@set TARGET_DIR=%1
@set BEFORE_CD=%cd%
@set ZIP_EXE="C:\Program Files\7-Zip\7z.exe"


@rem �o�͐�f�B���N�g��
@set outputDir=%BEFORE_CD%\output\%YYYYMMDD%%HHMMSS%
echo �o�͐�F %outputDir%
mkdir %outputDir%

@rem ���O
@set logPath=%BEFORE_CD%\output\%YYYYMMDD%%HHMMSS%\log_%YYYYMMDD%%HHMMSS%.log

echo =============================================
@rem ���ޕ����[�v
for /d %%I in (%TARGET_DIR%*) do (
  set targetPath=%%I
  set dirName=!targetPath:%TARGET_DIR%=!
  cd %%I
  if !dirName! == layer (
    @rem layer�̏ꍇ�́Apython����zip
    set dirName=python
  ) 
  echo !dirName!�̎��ނ����k���܂��B
  
  call %ZIP_EXE% a !dirName!.zip   >> %logPath%
  move !dirName!.zip %outputDir%   >> %logPath%
)
echo =============================================

echo �������܂����B�����L�[����������ƏI�����܂��B
pause > NUL

cd %BEFORE_CD%
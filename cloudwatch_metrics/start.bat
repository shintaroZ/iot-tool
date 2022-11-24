@echo off
@rem # -----------------------------------
@rem # CloudWatch���g���N�X�̎����o��
@rem # -----------------------------------


@set YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
@set HHMMSS=%time:~0,2%%time:~3,2%%time:~6,2%

@rem �p�����[�^����
if "%1" == "" (
	echo "�J�n����(UTC)���w�肵�ĉ������B��F2021-11-21T00:00:00.000Z"
	exit /b
)
if "%2" == "" (
	echo "�I������(UTC)���w�肵�ĉ������B��F2021-12-03T09:00:00.000Z"
	exit /b
)
@set STARTDT=%1
@set ENDDT=%2

@rem �o�͐�
IF NOT EXIST "output" (
  mkdir "output"
)

echo ******

@rem Lambda���s����
@set TITLE=Lambda_TAT
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[{\"expression\":\"SEARCH('{AWS/RDS,DBInstanceIdentifier}SwapUsage','Average',300)\",\"id\":\"e1\",\"period\":300,\"visible\":false}],[\"AWS/RDS\",\"FreeStorageSpace\",\"DBInstanceIdentifier\",\"mysql\",{\"id\":\"m2\",\"visible\":false}],[\".\",\"WriteIOPS\",\".\",\".\",{\"id\":\"m5\",\"visible\":false}],[\".\",\"WriteThroughput\",\".\",\".\",{\"id\":\"m6\",\"visible\":false}],[\".\",\"ReadThroughput\",\".\",\".\",{\"id\":\"m1\",\"visible\":false}],[\"AWS/Lambda\",\"Errors\",\"FunctionName\",\"latest_order\",{\"id\":\"m3\",\"visible\":false}],[\".\",\"Duration\",\".\",\".\",{\"id\":\"m4\"}]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0}},\"annotations\":{\"horizontal\":[{\"visible\":false,\"label\":\"WARNING\",\"value\":10,\"fill\":\"below\"},{\"visible\":false,\"label\":\"CRITICAL\",\"value\":90,\"fill\":\"above\"}]},\"stat\":\"Average\",\"period\":300,\"title\":\"%TITLE%\",\"setPeriodToTimeRange\":true,\"width\":1600,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul



@rem Lambda���s����
@set TITLE=limitJudge
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[{\"expression\":\"SEARCH('{AWS/RDS,DBInstanceIdentifier}SwapUsage','Average',300)\",\"id\":\"e1\",\"period\":300,\"visible\":false}],[\"AWS/RDS\",\"FreeStorageSpace\",\"DBInstanceIdentifier\",\"mysql\",{\"id\":\"m2\",\"visible\":false}],[\".\",\"WriteIOPS\",\".\",\".\",{\"id\":\"m5\",\"visible\":false}],[\".\",\"WriteThroughput\",\".\",\".\",{\"id\":\"m6\",\"visible\":false}],[\".\",\"ReadThroughput\",\".\",\".\",{\"id\":\"m1\",\"visible\":false}],[\"AWS/Lambda\",\"Errors\",\"FunctionName\",\"limitJudge\",{\"id\":\"m3\",\"visible\":false}],[\".\",\"Duration\",\".\",\".\",{\"id\":\"m4\"}]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0}},\"annotations\":{\"horizontal\":[{\"visible\":false,\"label\":\"WARNING\",\"value\":10,\"fill\":\"below\"},{\"visible\":false,\"label\":\"CRITICAL\",\"value\":90,\"fill\":\"above\"}]},\"stat\":\"Average\",\"period\":300,\"title\":\"%TITLE%\",\"setPeriodToTimeRange\":true,\"width\":1600,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul



@rem Lambda���s����
@set TITLE=mailsender
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[{\"expression\":\"SEARCH('{AWS/RDS,DBInstanceIdentifier}SwapUsage','Average',300)\",\"id\":\"e1\",\"period\":300,\"visible\":false}],[\"AWS/RDS\",\"FreeStorageSpace\",\"DBInstanceIdentifier\",\"mysql\",{\"id\":\"m2\",\"visible\":false}],[\".\",\"WriteIOPS\",\".\",\".\",{\"id\":\"m5\",\"visible\":false}],[\".\",\"WriteThroughput\",\".\",\".\",{\"id\":\"m6\",\"visible\":false}],[\".\",\"ReadThroughput\",\".\",\".\",{\"id\":\"m1\",\"visible\":false}],[\"AWS/Lambda\",\"Errors\",\"FunctionName\",\"mailsender\",{\"id\":\"m3\",\"visible\":false}],[\".\",\"Duration\",\".\",\".\",{\"id\":\"m4\"}]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0}},\"annotations\":{\"horizontal\":[{\"visible\":false,\"label\":\"WARNING\",\"value\":10,\"fill\":\"below\"},{\"visible\":false,\"label\":\"CRITICAL\",\"value\":90,\"fill\":\"above\"}]},\"stat\":\"Average\",\"period\":300,\"title\":\"%TITLE%\",\"setPeriodToTimeRange\":true,\"width\":1600,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul

@rem CPU�g�p��
@set TITLE=CPUUtilization
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"view\":\"timeSeries\",\"stacked\":false,\"metrics\":[[\"AWS/RDS\",\"CPUUtilization\",\"DBInstanceIdentifier\",\"mysql\"]],\"yAxis\":{\"left\":{\"min\":0,\"max\":100,\"label\":\"\"}},\"annotations\":{\"horizontal\":[{\"label\":\"WARNING\",\"value\":80,\"fill\":\"above\"},{\"label\":\"CRITICAL\",\"value\":90,\"fill\":\"above\"}]},\"width\":1600,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul

@rem CPU�N���W�b�g
@set TITLE=CPUCredit
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[{\"expression\":\"SEARCH('{AWS/RDS,DBInstanceIdentifier}SwapUsage','Average',300)\",\"id\":\"e1\",\"period\":300,\"visible\":false}],[\"AWS/RDS\",\"FreeStorageSpace\",\"DBInstanceIdentifier\",\"mysql\",{\"id\":\"m2\",\"visible\":false}],[\".\",\"WriteIOPS\",\".\",\".\",{\"id\":\"m5\",\"visible\":false}],[\".\",\"WriteThroughput\",\".\",\".\",{\"id\":\"m6\",\"visible\":false}],[\".\",\"ReadThroughput\",\".\",\".\",{\"id\":\"m1\",\"visible\":false}],[\"AWS/Lambda\",\"Errors\",\"FunctionName\",\"latest_order_dev\",{\"id\":\"m3\",\"visible\":false}],[\".\",\"Duration\",\".\",\".\",{\"id\":\"m4\",\"visible\":false}],[\"AWS/RDS\",\"CPUCreditBalance\",\"DBInstanceIdentifier\",\"mysql\",{\"id\":\"m7\"}],[\".\",\"CPUCreditUsage\",\".\",\".\",{\"id\":\"m8\"}]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0}},\"annotations\":{\"horizontal\":[{\"visible\":true,\"label\":\"WARNING\",\"value\":20,\"fill\":\"below\"},{\"visible\":true,\"label\":\"CRITICAL\",\"value\":10,\"fill\":\"below\"}]},\"stat\":\"Average\",\"period\":300,\"title\":\"%TITLE%\",\"setPeriodToTimeRange\":true,\"width\":1800,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul

@rem �������g�p��
@set TITLE=Memory
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[\"AWS/RDS\",\"CPUUtilization\",\"DBInstanceIdentifier\",\"mysql\",{\"visible\":false}],[\".\",\"FreeStorageSpace\",\".\",\".\",{\"visible\":false}],[\".\",\"FreeableMemory\",\".\",\".\"],[\".\",\"SwapUsage\",\".\",\".\"]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0}},\"annotations\":{\"horizontal\":[{\"visible\":true,\"label\":\"WARNING\",\"value\":20971520,\"fill\":\"below\"},{\"visible\":true,\"label\":\"CRITICAL\",\"value\":10485760,\"fill\":\"below\"}]},\"stat\":\"Average\",\"period\":300,\"title\":\"%TITLE%\",\"setPeriodToTimeRange\":true,\"width\":1600,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul

@rem �X�g���[�W
@set TITLE=Strage
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[\"AWS/RDS\",\"CPUUtilization\",\"DBInstanceIdentifier\",\"mysql\",{\"visible\":false}],[\".\",\"FreeStorageSpace\",\".\",\".\"],[\".\",\"FreeableMemory\",\".\",\".\",{\"visible\":false}],[\".\",\"SwapUsage\",\".\",\".\",{\"visible\":false}]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0,\"max\":21474836480}},\"annotations\":{\"horizontal\":[{\"visible\":true,\"label\":\"WARNING\",\"value\":2147483648,\"fill\":\"below\"},{\"visible\":true,\"label\":\"CRITICAL\",\"value\":1073741824,\"fill\":\"below\"}]},\"stat\":\"Average\",\"period\":300,\"setPeriodToTimeRange\":true,\"width\":1600,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul


@rem �f�B�X�NIO
@set TITLE=DiskIO
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[\"AWS/RDS\",\"CPUUtilization\",\"DBInstanceIdentifier\",\"mysql\",{\"visible\":false}],[\".\",\"FreeStorageSpace\",\".\",\".\",{\"visible\":false}],[\".\",\"FreeableMemory\",\".\",\".\",{\"visible\":false}],[\".\",\"SwapUsage\",\".\",\".\",{\"visible\":false}],[\".\",\"WriteThroughput\",\".\",\".\",{\"visible\":false}],[\".\",\"ReadThroughput\",\".\",\".\",{\"visible\":false}],[\"AWS/Lambda\",\"Errors\",\"FunctionName\",\"latest_order_dev\",{\"visible\":false}],[\"AWS/RDS\",\"CPUCreditBalance\",\"DBInstanceIdentifier\",\"mysql\",{\"visible\":false}],[\".\",\"WriteIOPS\",\".\",\".\"],[\".\",\"ReadIOPS\",\".\",\".\"]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0}},\"annotations\":{\"horizontal\":[{\"visible\":true,\"label\":\"WARNING\",\"value\":90,\"fill\":\"above\"},{\"visible\":true,\"label\":\"CRITICAL\",\"value\":100,\"fill\":\"above\"}]},\"view\":\"timeSeries\",\"stacked\":false,\"stat\":\"Average\",\"period\":300,\"width\":1800,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul


@rem RDS�ڑ���
@set TITLE=RDSConnection
@echo ============= %TITLE% Metrics Create Start =============
aws cloudwatch get-metric-widget-image --metric-widget {\"metrics\":[[\"AWS/RDS\",\"CPUUtilization\",\"DBInstanceIdentifier\",\"mysql\",{\"visible\":false}],[\".\",\"FreeStorageSpace\",\".\",\".\",{\"visible\":false}],[\".\",\"FreeableMemory\",\".\",\".\",{\"visible\":false}],[\".\",\"SwapUsage\",\".\",\".\",{\"visible\":false}],[\".\",\"WriteThroughput\",\".\",\".\",{\"visible\":false}],[\".\",\"ReadThroughput\",\".\",\".\",{\"visible\":false}],[\"AWS/Lambda\",\"Errors\",\"FunctionName\",\"latest_order_dev\",{\"visible\":false}],[\".\",\"Duration\",\".\",\".\",{\"visible\":false}],[\"AWS/RDS\",\"CPUCreditBalance\",\"DBInstanceIdentifier\",\"mysql\",{\"visible\":false}],[\".\",\"WriteIOPS\",\".\",\".\",{\"visible\":false}],[\".\",\"ReadIOPS\",\".\",\".\",{\"visible\":false}],[\".\",\"DatabaseConnections\",\".\",\".\"]],\"view\":\"timeSeries\",\"stacked\":false,\"yAxis\":{\"left\":{\"label\":\"\",\"min\":0,\"max\":66}},\"annotations\":{\"horizontal\":[{\"visible\":true,\"label\":\"WARNING\",\"value\":50,\"fill\":\"above\"},{\"visible\":true,\"label\":\"CRITICAL\",\"value\":60,\"fill\":\"above\"}]},\"view\":\"timeSeries\",\"stacked\":false,\"stat\":\"Average\",\"period\":300,\"width\":1800,\"height\":700,\"start\":\"%STARTDT%\",\"end\":\"%ENDDT%\"} --output-format "png" --output text --query MetricWidgetImage > metrics.dat

@rem png�f�R�[�h�ϊ�
certutil -f -decode metrics.dat output\%TITLE%_metrics_%YYYYMMDD%-%HHMMSS: =0%.png
del /q metrics.dat > nul



@echo ����!
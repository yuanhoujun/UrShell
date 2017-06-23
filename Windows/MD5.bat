@echo off

@echo.
@echo ----------------------------------------------------------------------------------------------------------
@echo " ______    __    __  ____    ____  ___      .__   __.   _______  _______  _______ .__   __.   _______"

@echo "/  __  \  |  |  |  | \   \  /   / /   \     |  \ |  |  /  _____||   ____||   ____||  \ |  |  /  _____|"

@echo "|  |  | | |  |  |  |  \   \/   / /  ^  \    |   \|  | |  |  __  |  |__   |  |__   |   \|  | |  |  __"

@echo "|  |  | | |  |  |  |   \_    _/ /  /_\  \   |  . `  | |  | |_ | |   __|  |   __|  |  . `  | |  | |_ |"

@echo "|  `--' | |  `--'  |     |  |  /  _____  \  |  |\   | |  |__| | |  |     |  |____ |  |\   | |  |__| |"

@echo "\______/   \______/      |__| /__/     \__\ |__| \__|  \______| |__|     |_______||__| \__|  \______|"
@echo ----------------------------------------------------------------------------------------------------------
@echo.

REM 获取拖拽文件的完整路径
set file_path=%1
set file_name=%~nx1
set file_name_no_suffix=%~n1

if "%file_name%"=="" (
	if "%file_name_suffix%"=="" (
		echo 使用方法：
		echo 拖拽文件到该文件上方等待计算结果即可
		pause
		exit
	)
)

REM 当前文件绝对路径：%file_path%, 当前文件名：%file_name%, 无后缀文件名：%file_name_no_suffix%
REM 尝试获取文件的MD5值
echo 正在计算中，请稍后......
echo.
echo.
set index=1
set md5Value=""
for /f "skip=1 delims=\n" %%i in ('certutil -hashfile %%file_path%% MD5') do (
 set md5Value=%%i 
 set /a index+=1
 if %index%==1 goto :print
)

:print

REM %md5Value%

REM 尝试去空格
set "md5Value=%md5Value: =%"

@echo ----------------------------------------------------------------------------------------------------------
echo 已经成功获取到文件【%file_name%】的MD5值: %md5Value%
echo.
REM 数据保存至文件中，并且复制到剪贴板

echo %md5Value% > "%file_name_no_suffix%.txt"

start %file_name_no_suffix%.txt
echo %md5Value% |clip

echo 文件【%file_name%】的MD5值已经保存至当前目录文件%file_name_no_suffix%.txt中,并且已经复制到剪贴板
echo 使用Ctrl+V粘贴即可
@echo ----------------------------------------------------------------------------------------------------------
pause
echo.
echo 谢谢使用！！！
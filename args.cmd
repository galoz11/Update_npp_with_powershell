@ECHO off
TITLE Galoz CMD and Powershell
ECHO.
ECHO 	##############################
ECHO 	## Galoz CMD and Powershell ##
ECHO 	##############################
ECHO.

powershell.exe -ExecutionPolicy ByPass -File "args1.ps1"
REM echo %errorlevel%
REM $LASTEXITCODE
echo Exit Code: %errorlevel%
pause
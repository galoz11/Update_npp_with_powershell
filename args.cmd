@REM Calling ps1 file from cmd and Bypass ExecutionPolicy
@REM Return Error code from last exeution

@ECHO off
powershell.exe -ExecutionPolicy ByPass -File "args1.ps1"

echo Exit Code: %errorlevel%
pause 

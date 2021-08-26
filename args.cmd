@ECHO off

powershell.exe -ExecutionPolicy ByPass -File "args1.ps1"

echo Exit Code: %errorlevel%
pause 
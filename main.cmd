@ECHO  SETLOCAL&& PUSHD "%~dp0"
TITLE Galoz CMD and Powershell
ECHO.
ECHO 	##############################
ECHO 	## Galoz CMD and Powershell ##
ECHO 	##############################
ECHO.
Powershell -ExecutionPolicy ByPass -File "power.ps1" "mosh1"

REM -Command "& '.\power.ps1 mosh2'"  
REM setlocal EnableDelayedExpansion
REM set n=0
REM for /f "delims=" %%a in ('Powershell.exe -NoProfile -ExecutionPolicy ByPass -Command .\power.ps1 mosh2') do (
   REM set vector[!n!]=%%a
   REM set /A n+=1
REM )
REM echo Exit Code is %LastExitCode%

REM Echo Value received from Powershell : %vector[1]%
ENDLOCAL 


pause
exit /b

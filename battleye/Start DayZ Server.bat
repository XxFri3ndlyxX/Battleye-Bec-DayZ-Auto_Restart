@echo off
TITLE DayZ SA Server - Status
COLOR 0A
:: Variables::
::Enter Your DayZServer_64.exe path.
set DAYZ-SA_SERVER_LOCATION="C:\Servers\DayZServer"
::Enter Your Bec.exe path.
set BEC_LOCATION="C:\Servers\DayZServer\battleye\Bec" 
::::::::::::::

echo Agusanz
goto checksv
pause

::This Will check if your server is running on start.
:checksv
tasklist /FI "IMAGENAME eq DayZServer_x64.exe" 2>NUL | find /I /N "DayZServer_x64.exe">NUL
if "%ERRORLEVEL%"=="0" goto checkbec
cls
echo Server is not running, taking care of it..
goto killsv

::This will check if your Bec is running.
:checkbec
tasklist /FI "IMAGENAME eq Bec.exe" 2>NUL | find /I /N "Bec.exe">NUL
if "%ERRORLEVEL%"=="0" goto loopsv
cls
echo Bec is not running, taking care of it..
goto startbec

::This will check every 30 second if your server is still running.
:loopsv
FOR /L %%s IN (30,-1,0) DO (
	cls
	echo Server is running. Checking again in %%s seconds.. 
	timeout 1 >nul
)
goto checksv

::This will shutdown your Server and Bec When this task is asked.
:killsv
taskkill /f /im Bec.exe
taskkill /f /im DayZServer_x64.exe
goto startsv

::This will start your Server and open up the console.
::Dont forget to edit your Port, Path location of Battleye and your Profiles.
:startsv
cls
echo Starting DayZ SA Server.
timeout 1 >nul
cls
echo Starting DayZ SA Server..
timeout 1 >nul
cls
echo Starting DayZ SA Server...
cd "%DAYZ-SA_SERVER_LOCATION%"
start DayZServer_x64.exe -config=serverDZ.cfg -port=2302 -dologs -adminlog -netlog -freezecheck -noFilePatching -BEpath=C:\Servers\DayZServer\battleye -profiles=C:\Servers\DayZServer\PlayerLogs
FOR /L %%s IN (30,-1,0) DO (
	cls
	echo Initializing server, wait %%s seconds to initialize Bec.. 
	timeout 1 >nul
)
goto startbec

::This will start your Bec and open up the console
:startbec
cls
echo Starting Bec.
timeout 1 >nul
cls
echo Starting Bec..
timeout 1 >nul
cls
echo Starting Bec...
timeout 1 >nul
cd "%BEC_LOCATION%"
start Bec.exe -f Config.cfg --dsc
goto checksv

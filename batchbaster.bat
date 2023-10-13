@echo off

:menu
cls
echo Select an option:
echo 1. Backup
echo 2. Cleanup
echo 3. File Synchronization
echo 4. Software Updates
echo 5. Scheduled Shutdown
echo 6. Network Diagnostics
echo 7. System Monitoring
echo 8. Quit
set /p choice=Enter the option number: 

if "%choice%"=="1" (
    call :backup
) else if "%choice%"=="2" (
    call :cleanup
) else if "%choice%"=="3" (
    call :sync
) else if "%choice%"=="4" (
    call :update
) else if "%choice%"=="5" (
    call :shutdown
) else if "%choice%"=="6" (
    call :diagnostics
) else if "%choice%"=="7" (
    call :monitor
) else if "%choice%"=="8" (
    exit /b 0
) else (
    echo Invalid choice. Please try again.
    pause
    goto menu
)

:backup
set /p source="Enter the source file or directory: "
set /p destination="Enter the destination directory: "

echo Copying %source% to %destination%...
rem Example: Copy specified files/directories
xcopy /s /e /i "%source%" "%destination%"
pause
goto menu

:cleanup
echo Cleaning up...
rem Example: Delete temporary files
del /q /s "C:\Temp\*.*"

echo Cleaning up DNS cache...
ipconfig /flushdns

echo Cleaning up Internet Explorer cache...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8

echo Cleaning up Microsoft Edge cache...
echo y|cd %localappdata%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\MicrosoftEdge\Cache&&del *&&cd User\Default&&del *&&cd

pause
goto menu

:sync
set /p source="Enter the source directory: "
set /p destination="Enter the destination directory: "

echo Synchronizing files from %source% to %destination%...
rem Example: Synchronize specified files/directories
robocopy "%source%" "%destination%" /MIR
pause
goto menu

:update
echo Checking for software updates...
rem Example: Check for updates using Windows Update
wuauclt /detectnow
pause
goto menu

:shutdown
:shutdownmenu
cls
echo Select a shutdown option:
echo 1. Shutdown in 30 minutes
echo 2. Shutdown in 60 minutes
echo 3. Shutdown in 2 hours
echo 4. Shutdown in 6 hours
echo 5. Shutdown in 12 hours
set /p shutdownchoice=Enter the option number:

if "%shutdownchoice%"=="1" (
    shutdown /s /f /t 1800
) else if "%shutdownchoice%"=="2" (
    shutdown /s /f /t 3600
) else if "%shutdownchoice%"=="3" (
    shutdown /s /f /t 7200
) else if "%shutdownchoice%"=="4" (
    shutdown /s /f /t 21600
) else if "%shutdownchoice%"=="5" (
    shutdown /s /f /t 43200
) else (
    echo Invalid choice. Please try again.
    pause
    goto shutdownmenu
)

echo The system will shutdown as selected.
pause
goto menu

:diagnostics
echo Running network diagnostics...

rem Example: Display IP configuration
ipconfig /all

rem Example: Check connectivity by pinging Google
ping google.com

rem Example: Display routing table
route print

rem Example: Show active network connections
netstat -ano

rem Example: Display ARP table
arp -a

pause
goto menu

:monitor
echo Monitoring system resources...
rem Example: List running processes
tasklist
pause
goto menu

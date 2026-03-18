@echo off
setlocal enabledelayedexpansion

:: ============================================================
::   SERIUM FREE  |  by Jimmy
::   Free community release — no serial required.
::   Auto-updates from GitHub on every launch.
:: ============================================================

:: ── CONFIG ──────────────────────────────────────────────────
set VERSION=1.5
set GITHUB_USER=YOUR_GITHUB_USERNAME
set GITHUB_REPO=serium-updates
set VERSION_URL=https://raw.githubusercontent.com/!GITHUB_USER!/!GITHUB_REPO!/main/version_free.json
set DOWNLOAD_URL=https://raw.githubusercontent.com/!GITHUB_USER!/!GITHUB_REPO!/main/Serium_Free.bat
:: ─────────────────────────────────────────────────────────────

:BOOT
cls
color 0B
call :WELCOME
call :CHECK_UPDATE
goto MAIN_MENU

:: ============================================================
::  AUTO-UPDATE CHECK
::  Downloads version_free.json from GitHub and compares.
::  If newer version exists, downloads new bat and restarts.
:: ============================================================
:CHECK_UPDATE
echo  [..] Checking for updates...
set TEMP_VER=%TEMP%\serium_free_ver.json
set TEMP_BAT=%TEMP%\serium_free_new.bat

:: Use PowerShell to fetch version.json (no extra tools needed)
powershell -Command "try { (Invoke-WebRequest -Uri '!VERSION_URL!' -UseBasicParsing -TimeoutSec 5).Content | Out-File -FilePath '!TEMP_VER!' -Encoding utf8 } catch { }" >nul 2>&1

if not exist "!TEMP_VER!" (
    echo  [!!] Could not reach update server. Running offline.
    timeout /t 1 >nul
    goto :EOF
)

:: Parse version from JSON
set REMOTE_VER=
for /f "tokens=2 delims=:, " %%A in ('findstr /i "version" "!TEMP_VER!"') do (
    if not defined REMOTE_VER set REMOTE_VER=%%~A
)

del "!TEMP_VER!" >nul 2>&1

if not defined REMOTE_VER (
    echo  [!!] Could not read version info.
    timeout /t 1 >nul
    goto :EOF
)

:: Simple version compare — if remote != current, update
if "!REMOTE_VER!"=="!VERSION!" (
    echo  [OK] Up to date ^(v!VERSION!^)
    timeout /t 1 >nul
    goto :EOF
)

:: Update available
cls
echo.
echo  +==============================================================+
echo  ^|                                                              ^|
echo  ^|   [>>]  UPDATE AVAILABLE  v!REMOTE_VER!                           ^|
echo  ^|                                                              ^|
echo  ^|   Downloading update...                                      ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.

powershell -Command "try { (Invoke-WebRequest -Uri '!DOWNLOAD_URL!' -UseBasicParsing).Content | Out-File -FilePath '!TEMP_BAT!' -Encoding ascii } catch { exit 1 }" >nul 2>&1

if not exist "!TEMP_BAT!" (
    echo  [!!] Download failed. Running current version.
    timeout /t 2 >nul
    goto :EOF
)

:: Replace this file with the new one and restart
copy /y "!TEMP_BAT!" "%~f0" >nul 2>&1
del "!TEMP_BAT!" >nul 2>&1

echo  [OK] Updated to v!REMOTE_VER! — restarting...
timeout /t 2 >nul
start "" "%~f0"
exit

goto :EOF

:: ============================================================
::  WELCOME SCREEN
:: ============================================================
:WELCOME
cls
echo.
echo  +==============================================================+
echo  ^|                                                              ^|
echo  ^|    ___  ____  ____  ____  _  _  __  __                      ^|
echo  ^|   / __)(  __)(  _ \(  __)( )( )(  \/  )                     ^|
echo  ^|   \__ \ ) _)  )   / ) _)  )()(  )    (                      ^|
echo  ^|   (___/(____)(__\_)(____)(____/(__/\__)                      ^|
echo  ^|                                                              ^|
echo  ^|         --- F R E E  E D I T I O N  v!VERSION! ---              ^|
echo  ^|                                                              ^|
echo  ^|         [ Your All-In-One Command Center ]                   ^|
echo  ^|         [ Free community release by Jimmy ]                  ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.
echo             Initializing Serium Free...
echo.
goto :EOF

:: ============================================================
::  MAIN MENU
:: ============================================================
:MAIN_MENU
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                      MAIN MENU                            ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   [1]  App Launcher        Launch installed apps          ^|
echo  ^|   [2]  System Tools        Quick system utilities         ^|
echo  ^|   [3]  Network Tools       Ping, IP info, and more        ^|
echo  ^|   [4]  File Utilities      Open folders and files         ^|
echo  ^|   [5]  Batch Manager       Run and manage .bat files      ^|
echo  ^|                                                           ^|
echo  ^|   Want more features? Get SERIUM Pro:                     ^|
echo  ^|   discord.gg/YOUR_INVITE_HERE                             ^|
echo  ^|                                                           ^|
echo  ^|   [0]  Exit                                               ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
echo  Version: !VERSION! ^| github.com/!GITHUB_USER!/!GITHUB_REPO!
echo.
set /p CHOICE="  >> Enter your choice: "

if "%CHOICE%"=="1" goto APP_LAUNCHER
if "%CHOICE%"=="2" goto SYSTEM_TOOLS
if "%CHOICE%"=="3" goto NETWORK_TOOLS
if "%CHOICE%"=="4" goto FILE_UTILITIES
if "%CHOICE%"=="5" goto BATCH_MANAGER
if "%CHOICE%"=="0" goto EXIT
echo  [!] Invalid choice.
timeout /t 1 >nul
goto MAIN_MENU

:: ============================================================
::  APP LAUNCHER
:: ============================================================
:APP_LAUNCHER
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                     APP LAUNCHER                          ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   BROWSERS                                                ^|
echo  ^|   [1]   Google Chrome                                     ^|
echo  ^|   [2]   Microsoft Edge                                    ^|
echo  ^|   [3]   Firefox                                           ^|
echo  ^|                                                           ^|
echo  ^|   PRODUCTIVITY                                            ^|
echo  ^|   [4]   Notepad                                           ^|
echo  ^|   [5]   Notepad++                                         ^|
echo  ^|   [6]   VS Code                                           ^|
echo  ^|   [7]   File Explorer                                     ^|
echo  ^|                                                           ^|
echo  ^|   TOOLS                                                   ^|
echo  ^|   [8]   Calculator                                        ^|
echo  ^|   [9]   Task Manager                                      ^|
echo  ^|   [10]  Snipping Tool                                     ^|
echo  ^|   [C]   Custom path                                       ^|
echo  ^|   [B]   Back                                              ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p APP_CHOICE="  >> Select app: "

if /i "%APP_CHOICE%"=="1"  ( start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" 2>nul )
if /i "%APP_CHOICE%"=="2"  ( start msedge )
if /i "%APP_CHOICE%"=="3"  ( start "" "C:\Program Files\Mozilla Firefox\firefox.exe" 2>nul )
if /i "%APP_CHOICE%"=="4"  ( start notepad )
if /i "%APP_CHOICE%"=="5"  ( start "" "C:\Program Files\Notepad++\notepad++.exe" 2>nul )
if /i "%APP_CHOICE%"=="6"  ( start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" 2>nul )
if /i "%APP_CHOICE%"=="7"  ( start explorer )
if /i "%APP_CHOICE%"=="8"  ( start calc )
if /i "%APP_CHOICE%"=="9"  ( start taskmgr )
if /i "%APP_CHOICE%"=="10" ( start snippingtool )
if /i "%APP_CHOICE%"=="C" (
    set /p CPATH="  >> Enter path to app: "
    start "" "!CPATH!" 2>nul
)
if /i "%APP_CHOICE%"=="B" goto MAIN_MENU
timeout /t 1 >nul
goto APP_LAUNCHER

:: ============================================================
::  SYSTEM TOOLS
:: ============================================================
:SYSTEM_TOOLS
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                     SYSTEM TOOLS                          ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   [1]   System Info                                       ^|
echo  ^|   [2]   Disk Usage                                        ^|
echo  ^|   [3]   Running Processes                                 ^|
echo  ^|   [4]   Clear Temp Files                                  ^|
echo  ^|   [5]   Task Manager                                      ^|
echo  ^|   [6]   Restart Computer                                  ^|
echo  ^|   [7]   Shutdown Computer                                 ^|
echo  ^|   [B]   Back                                              ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p ST="  >> Choice: "
if "%ST%"=="1" ( cls & systeminfo & pause )
if "%ST%"=="2" ( cls & wmic logicaldisk get caption,freespace,size,volumename & pause )
if "%ST%"=="3" ( cls & tasklist & pause )
if "%ST%"=="4" ( del /q /f /s "%TEMP%\*" 2>nul & echo [OK] Temp files cleared & timeout /t 2 >nul )
if "%ST%"=="5" ( start taskmgr )
if "%ST%"=="6" ( set /p C="Restart now? (Y/N): " & if /i "!C!"=="Y" shutdown /r /t 5 )
if "%ST%"=="7" ( set /p C="Shutdown now? (Y/N): " & if /i "!C!"=="Y" shutdown /s /t 5 )
if /i "%ST%"=="B" goto MAIN_MENU
goto SYSTEM_TOOLS

:: ============================================================
::  NETWORK TOOLS
:: ============================================================
:NETWORK_TOOLS
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                    NETWORK TOOLS                          ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   [1]  IP Configuration                                   ^|
echo  ^|   [2]  Ping a Host                                        ^|
echo  ^|   [3]  Traceroute                                         ^|
echo  ^|   [4]  DNS Lookup                                         ^|
echo  ^|   [5]  Flush DNS Cache                                    ^|
echo  ^|   [6]  Test Internet                                      ^|
echo  ^|   [7]  Network Settings                                   ^|
echo  ^|   [B]  Back                                               ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p NT="  >> Choice: "
if "%NT%"=="1" ( cls & ipconfig /all & pause )
if "%NT%"=="2" ( set /p H="Host: " & cls & ping !H! & pause )
if "%NT%"=="3" ( set /p H="Host: " & cls & tracert !H! & pause )
if "%NT%"=="4" ( set /p H="Domain: " & cls & nslookup !H! & pause )
if "%NT%"=="5" ( ipconfig /flushdns & echo [OK] DNS flushed & timeout /t 2 >nul )
if "%NT%"=="6" ( cls & ping google.com & pause )
if "%NT%"=="7" ( start ms-settings:network )
if /i "%NT%"=="B" goto MAIN_MENU
goto NETWORK_TOOLS

:: ============================================================
::  FILE UTILITIES
:: ============================================================
:FILE_UTILITIES
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                    FILE UTILITIES                         ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   [1]  Open Desktop                                       ^|
echo  ^|   [2]  Open Downloads                                     ^|
echo  ^|   [3]  Open Documents                                     ^|
echo  ^|   [4]  Open Pictures                                      ^|
echo  ^|   [5]  Open This PC                                       ^|
echo  ^|   [6]  Open Custom Folder                                 ^|
echo  ^|   [7]  Open a File                                        ^|
echo  ^|   [B]  Back                                               ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p FU="  >> Choice: "
if "%FU%"=="1" ( start explorer "%USERPROFILE%\Desktop" )
if "%FU%"=="2" ( start explorer "%USERPROFILE%\Downloads" )
if "%FU%"=="3" ( start explorer "%USERPROFILE%\Documents" )
if "%FU%"=="4" ( start explorer "%USERPROFILE%\Pictures" )
if "%FU%"=="5" ( start explorer shell:MyComputerFolder )
if "%FU%"=="6" ( set /p P="Folder path: " & start explorer "!P!" )
if "%FU%"=="7" ( set /p P="File path: " & start "" "!P!" 2>nul )
if /i "%FU%"=="B" goto MAIN_MENU
timeout /t 1 >nul
goto FILE_UTILITIES

:: ============================================================
::  BATCH MANAGER
:: ============================================================
:BATCH_MANAGER
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                  BATCH MANAGER                            ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   [1]  Run a batch file                                   ^|
echo  ^|   [2]  Create a new batch file                            ^|
echo  ^|   [3]  Edit a batch file in Notepad                       ^|
echo  ^|   [B]  Back                                               ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p BM="  >> Choice: "
if "%BM%"=="1" ( set /p P=".bat path: " & if exist "!P!" (call "!P!") else echo [!] Not found )
if "%BM%"=="2" ( set /p N="Name (no .bat): " & echo @echo off>"!N!.bat" & echo echo New script>>"!N!.bat" & echo pause>>"!N!.bat" & start notepad "!N!.bat" )
if "%BM%"=="3" ( set /p P=".bat path: " & start notepad "!P!" )
if /i "%BM%"=="B" goto MAIN_MENU
timeout /t 1 >nul
goto BATCH_MANAGER

:: ============================================================
::  HEADER / EXIT
:: ============================================================
:HEADER
echo  +==============================================================+
echo  ^|   ##  SERIUM FREE  v!VERSION!   by Jimmy   [ Free Edition ]      ^|
echo  +==============================================================+
goto :EOF

:EXIT
cls
echo.
echo  Thanks for using Serium Free!
echo  For more features, join Discord: discord.gg/YOUR_INVITE_HERE
echo.
timeout /t 2 >nul
exit

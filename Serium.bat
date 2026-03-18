@echo off
setlocal enabledelayedexpansion

:: ============================================================
::   SERIUM MULTITOOL  |  v1.0
::   Session restore, app launcher, batch manager, and more.
:: ============================================================

:BOOT
cls
color 0B
call :WELCOME

:: ── SERIAL + UPDATE CHECK ──────────────────────────────────────
:: Calls serium_updater.py which validates serial against GitHub
:: and checks for new versions. Exit codes:
::   0 = valid + up to date
::   1 = serial invalid / revoked  → show error + exit
::   2 = update downloaded         → restart bat
::   3 = offline / skip            → continue
python --version >nul 2>&1
if not errorlevel 1 (
    set UPDATER=%~dp0serium_updater.py
    if exist "!UPDATER!" (
        echo.
        echo  [..] Checking license and updates...
        python "!UPDATER!" full
        set UPDATER_EXIT=!errorlevel!

        if "!UPDATER_EXIT!"=="1" goto SERIAL_ERROR
        if "!UPDATER_EXIT!"=="2" goto UPDATE_RESTART
    )
)
goto MAIN_MENU


:SERIAL_ERROR
cls
echo.
echo  +==============================================================+
echo  ^|                                                              ^|
echo  ^|   [X]  LICENSE ERROR                                        ^|
echo  ^|                                                              ^|
echo  ^|   Your serial key is invalid, revoked, or this copy         ^|
echo  ^|   is already activated on a different PC.                   ^|
echo  ^|                                                              ^|
echo  ^|   To get a valid serial key:                                 ^|
echo  ^|   - Join the SERIUM Discord                                  ^|
echo  ^|   - DM the owner or use /checkserial                        ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.

:: If no license file exists, prompt user to enter their key
set LICENSE_FILE=%~dp0serium_license.txt
if not exist "!LICENSE_FILE!" (
    echo  No license file found. Enter your serial key below.
    echo  It was sent to you via Discord DM.
    echo.
    set /p USER_SERIAL="  >> Enter serial key (SERIUM-XXXX-XXXX-XXXX-XXXX): "
    echo !USER_SERIAL!> "!LICENSE_FILE!"
    echo.
    echo  [OK] Serial saved. Relaunch Serium to activate.
    echo.
) else (
    echo  If you believe this is a mistake, contact the SERIUM owner on Discord.
)
echo  Press any key to exit...
pause >nul
exit


:UPDATE_RESTART
cls
echo.
echo  +==============================================================+
echo  ^|                                                              ^|
echo  ^|   [>>]  UPDATE APPLIED                                      ^|
echo  ^|                                                              ^|
echo  ^|   A new version of Serium has been installed.               ^|
echo  ^|   Restarting now...                                          ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.
timeout /t 2 >nul
start "" "%~f0"
exit

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
echo  ^|            --- M U L T I T O O L  v1.0 ---                  ^|
echo  ^|                                                              ^|
echo  ^|         [ Your All-In-One Command Center ]                   ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.
echo            Initializing Serium environment...
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
echo  ^|   [2]  Batch File Manager  Run and manage .bat files      ^|
echo  ^|   [3]  System Tools        Quick system utilities         ^|
echo  ^|   [4]  Network Tools       Ping, IP info, and more        ^|
echo  ^|   [5]  File Utilities      Open folders and files         ^|
echo  ^|   [6]  Session Restore     Reopen apps from last session  ^|
echo  ^|   [7]  Settings            Customize Serium               ^|
echo  ^|   [8]  Web Control Panel   Open browser dashboard         ^|
echo  ^|   [0]  Exit                Close Serium Multitool         ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p CHOICE="  >> Enter your choice: "

if "%CHOICE%"=="1" goto APP_LAUNCHER
if "%CHOICE%"=="2" goto BATCH_MANAGER
if "%CHOICE%"=="3" goto SYSTEM_TOOLS
if "%CHOICE%"=="4" goto NETWORK_TOOLS
if "%CHOICE%"=="5" goto FILE_UTILITIES
if "%CHOICE%"=="6" goto SESSION_RESTORE
if "%CHOICE%"=="7" goto SETTINGS
if "%CHOICE%"=="8" goto WEB_UI
if "%CHOICE%"=="0" goto EXIT
echo.
echo  [!] Invalid choice. Try again.
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
echo  ^|                                                           ^|
echo  ^|   PRODUCTIVITY                                            ^|
echo  ^|   [2]   Notepad++                                         ^|
echo  ^|   [3]   VS Code                                           ^|
echo  ^|   [4]   File Explorer                                     ^|
echo  ^|                                                           ^|
echo  ^|   MEDIA AND TOOLS                                         ^|
echo  ^|   [5]   Calculator                                        ^|
echo  ^|   [6]   Paint                                             ^|
echo  ^|   [7]   Snipping Tool                                     ^|
echo  ^|   [8]   Task Manager                                      ^|
echo  ^|   [9]   Nvidia App                                        ^|
echo  ^|                                                           ^|
echo  ^|   GAMING                                                  ^|
echo  ^|   [10]  Spotify                                           ^|
echo  ^|   [11]  Discord                                           ^|
echo  ^|   [12]  Xbox App                                          ^|
echo  ^|   [13]  Steam                                             ^|
echo  ^|   [14]  Ubisoft Connect                                   ^|
echo  ^|                                                           ^|
echo  ^|   NETWORK AND SECURITY                                    ^|
echo  ^|   [15]  Wireshark                                         ^|
echo  ^|   [16]  PuTTY                                             ^|
echo  ^|   [17]  Portmaster                                        ^|
echo  ^|                                                           ^|
echo  ^|   [C]   Launch Custom App (enter path)                    ^|
echo  ^|   [B]   Back to Main Menu                                 ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p APP_CHOICE="  >> Select app to launch: "

if /i "%APP_CHOICE%"=="1" (
    call :LAUNCH_AND_LOG chrome "C:\Program Files\Google\Chrome\Application\chrome.exe"
    if errorlevel 1 call :LAUNCH_AND_LOG chrome "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
)
if /i "%APP_CHOICE%"=="2"  ( call :LAUNCH_AND_LOG notepadpp "C:\Program Files\Notepad++\notepad++.exe" )
if /i "%APP_CHOICE%"=="3"  ( call :LAUNCH_AND_LOG vscode "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" )
if /i "%APP_CHOICE%"=="4"  ( call :LAUNCH_AND_LOG explorer explorer )
if /i "%APP_CHOICE%"=="5"  ( call :LAUNCH_AND_LOG calc calc )
if /i "%APP_CHOICE%"=="6"  ( call :LAUNCH_AND_LOG paint mspaint )
if /i "%APP_CHOICE%"=="7"  ( call :LAUNCH_AND_LOG snip snippingtool )
if /i "%APP_CHOICE%"=="8"  ( call :LAUNCH_AND_LOG taskmgr taskmgr )
if /i "%APP_CHOICE%"=="9"  ( call :LAUNCH_AND_LOG nvidia "%LOCALAPPDATA%\NVIDIA Corporation\NVIDIA app\CEF\nvidia_app.exe" )
if /i "%APP_CHOICE%"=="10" ( call :LAUNCH_AND_LOG spotify "%APPDATA%\Spotify\Spotify.exe" )
if /i "%APP_CHOICE%"=="11" ( call :LAUNCH_AND_LOG discord "%LOCALAPPDATA%\Discord\Update.exe" --processStart Discord.exe )
if /i "%APP_CHOICE%"=="12" ( call :LAUNCH_AND_LOG xbox "C:\Windows\System32\cmd.exe" /c start xbox )
if /i "%APP_CHOICE%"=="13" ( call :LAUNCH_AND_LOG steam "C:\Program Files (x86)\Steam\steam.exe" )
if /i "%APP_CHOICE%"=="14" ( call :LAUNCH_AND_LOG ubisoft "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\UbisoftConnect.exe" )
if /i "%APP_CHOICE%"=="15" ( call :LAUNCH_AND_LOG wireshark "C:\Program Files\Wireshark\Wireshark.exe" )
if /i "%APP_CHOICE%"=="16" ( call :LAUNCH_AND_LOG putty "C:\Program Files\PuTTY\putty.exe" )
if /i "%APP_CHOICE%"=="17" ( call :LAUNCH_AND_LOG portmaster "C:\Program Files\Portmaster\portmaster.exe" )

if /i "%APP_CHOICE%"=="C" (
    echo.
    set /p CUSTOM_PATH="  >> Enter full path to app (.exe): "
    start "" "!CUSTOM_PATH!" 2>nul
    call :SESSION_LOG_WRITE "!CUSTOM_PATH!"
    echo  [OK] Launch command sent.
    timeout /t 2 >nul
)

if /i "%APP_CHOICE%"=="B" goto MAIN_MENU
timeout /t 1 >nul
goto APP_LAUNCHER

:: ============================================================
::  SESSION RESTORE
:: ============================================================
:SESSION_RESTORE
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                   SESSION RESTORE                         ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   Reopen all apps that were running in your last          ^|
echo  ^|   Serium session before shutdown or exit.                 ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.

set SESSION_FILE=%~dp0serium_session.txt

if not exist "!SESSION_FILE!" (
    echo  [!] No saved session found.
    echo      Launch some apps through Serium first,
    echo      then exit via [0] to save your session.
    echo.
    echo  Press any key to return...
    pause >nul
    goto MAIN_MENU
)

echo  Apps saved in last session:
echo  -----------------------------------------------------------
set SES_COUNT=0
for /f "usebackq delims=" %%A in ("!SESSION_FILE!") do (
    set /a SES_COUNT+=1
    echo    [!SES_COUNT!]  %%A
    set "SAPP_!SES_COUNT!=%%A"
)
echo.
echo  +-----------------------------------------------------------+
echo  ^|   [1]  Restore ALL apps from last session                 ^|
echo  ^|   [2]  Pick individual apps to restore                    ^|
echo  ^|   [3]  Clear saved session                                ^|
echo  ^|   [B]  Back to Main Menu                                  ^|
echo  +-----------------------------------------------------------+
echo.
set /p SR_CHOICE="  >> Enter your choice: "

if "%SR_CHOICE%"=="1" goto SR_RESTORE_ALL
if "%SR_CHOICE%"=="2" goto SR_RESTORE_PICK
if "%SR_CHOICE%"=="3" goto SR_CLEAR
if /i "%SR_CHOICE%"=="B" goto MAIN_MENU
goto SESSION_RESTORE

:SR_RESTORE_ALL
echo.
echo  [*] Restoring session apps...
for /f "usebackq delims=" %%A in ("!SESSION_FILE!") do (
    echo  [>>] Starting: %%A
    start "" "%%A" 2>nul
    timeout /t 1 >nul
)
echo.
echo  [OK] All session apps launched.
echo  Press any key to return...
pause >nul
goto MAIN_MENU

:SR_RESTORE_PICK
echo.
set /p PICK_NUM="  >> Enter app number to launch (or B to go back): "
if /i "!PICK_NUM!"=="B" goto SESSION_RESTORE
if defined SAPP_%PICK_NUM% (
    echo  [>>] Starting: !SAPP_%PICK_NUM%!
    start "" "!SAPP_%PICK_NUM%!" 2>nul
    echo  [OK] Launched.
) else (
    echo  [!] Invalid number.
)
timeout /t 2 >nul
goto SESSION_RESTORE

:SR_CLEAR
del /f /q "!SESSION_FILE!" 2>nul
echo.
echo  [OK] Session cleared.
timeout /t 2 >nul
goto MAIN_MENU

:: ============================================================
::  SESSION LOGGING HELPERS
:: ============================================================

:: Call as: call :LAUNCH_AND_LOG label "path"
:LAUNCH_AND_LOG
set APP_LABEL=%~1
set APP_PATH=%~2
start "" "%APP_PATH%" 2>nul
if not errorlevel 1 (
    call :SESSION_LOG_WRITE "%APP_PATH%"
)
timeout /t 1 >nul
goto :EOF

:SESSION_LOG_WRITE
set LOG_ENTRY=%~1
set SESSION_FILE=%~dp0serium_session.txt
:: Check if entry already exists to avoid duplicates
set ALREADY=0
if exist "!SESSION_FILE!" (
    for /f "usebackq delims=" %%L in ("!SESSION_FILE!") do (
        if /i "%%L"=="!LOG_ENTRY!" set ALREADY=1
    )
)
if "!ALREADY!"=="0" (
    echo !LOG_ENTRY!>> "!SESSION_FILE!"
)
goto :EOF

:: ============================================================
::  BATCH FILE MANAGER
:: ============================================================
:BATCH_MANAGER
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                  BATCH FILE MANAGER                       ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   [1]  Run a batch file (enter full path)                 ^|
echo  ^|   [2]  Browse and run .bat files in a folder              ^|
echo  ^|   [3]  Run batch file from Serium's folder                ^|
echo  ^|   [4]  Open a batch file in Notepad (view/edit)           ^|
echo  ^|   [5]  Create a new blank batch file                      ^|
echo  ^|   [B]  Back to Main Menu                                  ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p BM_CHOICE="  >> Enter your choice: "

if "%BM_CHOICE%"=="1" goto BM_RUN_PATH
if "%BM_CHOICE%"=="2" goto BM_BROWSE
if "%BM_CHOICE%"=="3" goto BM_LOCAL
if "%BM_CHOICE%"=="4" goto BM_EDIT
if "%BM_CHOICE%"=="5" goto BM_CREATE
if /i "%BM_CHOICE%"=="B" goto MAIN_MENU
goto BATCH_MANAGER

:BM_RUN_PATH
echo.
set /p BAT_PATH="  >> Enter full path to .bat file: "
if exist "!BAT_PATH!" (
    echo  [OK] Running: !BAT_PATH!
    call "!BAT_PATH!"
) else (
    echo  [!] File not found: !BAT_PATH!
)
echo.
echo  Press any key to return...
pause >nul
goto BATCH_MANAGER

:BM_BROWSE
echo.
set /p BROWSE_DIR="  >> Enter folder path to browse: "
if not exist "!BROWSE_DIR!" (
    echo  [!] Folder not found.
    timeout /t 2 >nul
    goto BATCH_MANAGER
)
cls
call :HEADER
echo.
echo  Batch files found in: !BROWSE_DIR!
echo  -----------------------------------------------------------
echo.
set COUNT=0
for %%F in ("!BROWSE_DIR!\*.bat") do (
    set /a COUNT+=1
    set "FILE_!COUNT!=%%F"
    echo    [!COUNT!]  %%~nxF
)
if !COUNT!==0 (
    echo  [!] No .bat files found in that folder.
    timeout /t 2 >nul
    goto BATCH_MANAGER
)
echo.
echo  [B]  Back
echo.
set /p FILE_NUM="  >> Enter number to run: "
if /i "!FILE_NUM!"=="B" goto BATCH_MANAGER
if defined FILE_%FILE_NUM% (
    echo  [OK] Running: !FILE_%FILE_NUM%!
    call "!FILE_%FILE_NUM%!"
    echo.
    echo  Script completed. Press any key...
    pause >nul
) else (
    echo  [!] Invalid selection.
    timeout /t 2 >nul
)
goto BATCH_MANAGER

:BM_LOCAL
cls
call :HEADER
echo.
echo  Batch files in Serium's folder:
echo  -----------------------------------------------------------
echo.
set COUNT=0
for %%F in ("%~dp0*.bat") do (
    if /i not "%%~nxF"=="%~nx0" (
        set /a COUNT+=1
        set "LFILE_!COUNT!=%%F"
        echo    [!COUNT!]  %%~nxF
    )
)
if !COUNT!==0 (
    echo  [!] No other .bat files found in this folder.
    timeout /t 2 >nul
    goto BATCH_MANAGER
)
echo.
echo  [B]  Back
echo.
set /p LFILE_NUM="  >> Enter number to run: "
if /i "!LFILE_NUM!"=="B" goto BATCH_MANAGER
if defined LFILE_%LFILE_NUM% (
    echo  [OK] Running: !LFILE_%LFILE_NUM%!
    call "!LFILE_%LFILE_NUM%!"
    echo.
    echo  Script completed. Press any key...
    pause >nul
) else (
    echo  [!] Invalid selection.
    timeout /t 2 >nul
)
goto BATCH_MANAGER

:BM_EDIT
echo.
set /p EDIT_PATH="  >> Enter full path to .bat file to open in Notepad: "
if exist "!EDIT_PATH!" (
    start notepad "!EDIT_PATH!"
    echo  [OK] Opened in Notepad.
) else (
    echo  [!] File not found.
)
timeout /t 2 >nul
goto BATCH_MANAGER

:BM_CREATE
echo.
set /p NEW_NAME="  >> Enter name for new batch file (without .bat): "
set "NEW_FILE=%~dp0!NEW_NAME!.bat"
if exist "!NEW_FILE!" (
    echo  [!] File already exists.
) else (
    echo @echo off > "!NEW_FILE!"
    echo echo New Serium batch script >> "!NEW_FILE!"
    echo pause >> "!NEW_FILE!"
    echo  [OK] Created: !NEW_FILE!
    start notepad "!NEW_FILE!"
)
timeout /t 2 >nul
goto BATCH_MANAGER

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
echo  ^|   [1]   System Info (systeminfo)                          ^|
echo  ^|   [2]   Disk Usage (all drives)                           ^|
echo  ^|   [3]   Running Processes                                 ^|
echo  ^|   [4]   Clear Temp Files                                  ^|
echo  ^|   [5]   Check Disk (chkdsk C:)                            ^|
echo  ^|   [6]   System File Checker (sfc /scannow)                ^|
echo  ^|   [7]   Restart Computer                                  ^|
echo  ^|   [8]   Shutdown Computer                                 ^|
echo  ^|   [9]   Open Task Manager                                 ^|
echo  ^|   [10]  Open Device Manager                               ^|
echo  ^|   [B]   Back to Main Menu                                 ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p ST_CHOICE="  >> Enter your choice: "

if "%ST_CHOICE%"=="1"  ( cls & systeminfo & pause )
if "%ST_CHOICE%"=="2"  ( cls & wmic logicaldisk get caption,freespace,size,volumename & pause )
if "%ST_CHOICE%"=="3"  ( cls & tasklist & pause )
if "%ST_CHOICE%"=="4"  (
    echo  [*] Clearing temp files...
    del /q /f /s "%TEMP%\*" 2>nul
    echo  [OK] Temp files cleared.
    timeout /t 2 >nul
)
if "%ST_CHOICE%"=="5"  ( cls & chkdsk C: & pause )
if "%ST_CHOICE%"=="6"  ( cls & sfc /scannow & pause )
if "%ST_CHOICE%"=="7"  (
    echo.
    set /p CONF="  [!] Restart NOW? (Y/N): "
    if /i "!CONF!"=="Y" shutdown /r /t 5
)
if "%ST_CHOICE%"=="8"  (
    echo.
    set /p CONF="  [!] Shutdown NOW? (Y/N): "
    if /i "!CONF!"=="Y" shutdown /s /t 5
)
if "%ST_CHOICE%"=="9"  ( start taskmgr )
if "%ST_CHOICE%"=="10" ( start devmgmt.msc )
if /i "%ST_CHOICE%"=="B" goto MAIN_MENU
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
echo  ^|   [1]  Show IP Configuration                              ^|
echo  ^|   [2]  Ping a Host                                        ^|
echo  ^|   [3]  Traceroute to a Host                               ^|
echo  ^|   [4]  DNS Lookup (nslookup)                              ^|
echo  ^|   [5]  Show Active Connections (netstat)                  ^|
echo  ^|   [6]  Flush DNS Cache                                    ^|
echo  ^|   [7]  Test Internet (ping google.com)                    ^|
echo  ^|   [8]  Open Network Settings                              ^|
echo  ^|   [B]  Back to Main Menu                                  ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p NT_CHOICE="  >> Enter your choice: "

if "%NT_CHOICE%"=="1" ( cls & ipconfig /all & pause )
if "%NT_CHOICE%"=="2" (
    set /p PING_HOST="  >> Enter host to ping: "
    cls & ping !PING_HOST! & pause
)
if "%NT_CHOICE%"=="3" (
    set /p TRACE_HOST="  >> Enter host for traceroute: "
    cls & tracert !TRACE_HOST! & pause
)
if "%NT_CHOICE%"=="4" (
    set /p NS_HOST="  >> Enter domain to look up: "
    cls & nslookup !NS_HOST! & pause
)
if "%NT_CHOICE%"=="5" ( cls & netstat -an & pause )
if "%NT_CHOICE%"=="6" (
    ipconfig /flushdns
    echo  [OK] DNS cache flushed.
    timeout /t 2 >nul
)
if "%NT_CHOICE%"=="7" ( cls & ping google.com & pause )
if "%NT_CHOICE%"=="8" ( start ms-settings:network & timeout /t 1 >nul )
if /i "%NT_CHOICE%"=="B" goto MAIN_MENU
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
echo  ^|   [1]  Open a folder in Explorer                          ^|
echo  ^|   [2]  Open Desktop                                       ^|
echo  ^|   [3]  Open Downloads                                     ^|
echo  ^|   [4]  Open Documents                                     ^|
echo  ^|   [5]  Open This PC                                       ^|
echo  ^|   [6]  Search for a file by name                          ^|
echo  ^|   [7]  Open a file (enter path)                           ^|
echo  ^|   [B]  Back to Main Menu                                  ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p FU_CHOICE="  >> Enter your choice: "

if "%FU_CHOICE%"=="1" (
    set /p OPEN_DIR="  >> Enter folder path: "
    start explorer "!OPEN_DIR!"
)
if "%FU_CHOICE%"=="2" ( start explorer "%USERPROFILE%\Desktop" )
if "%FU_CHOICE%"=="3" ( start explorer "%USERPROFILE%\Downloads" )
if "%FU_CHOICE%"=="4" ( start explorer "%USERPROFILE%\Documents" )
if "%FU_CHOICE%"=="5" ( start explorer "shell:MyComputerFolder" )
if "%FU_CHOICE%"=="6" (
    set /p SEARCH_NAME="  >> Enter filename to search (e.g. report.txt): "
    set /p SEARCH_DIR="  >> Enter directory to search in (e.g. C:\): "
    cls
    echo Searching...
    dir /s /b "!SEARCH_DIR!\!SEARCH_NAME!" 2>nul
    pause
)
if "%FU_CHOICE%"=="7" (
    set /p FILE_OPEN="  >> Enter full path to file: "
    start "" "!FILE_OPEN!" 2>nul
    echo  [OK] Open command sent.
    timeout /t 2 >nul
)
if /i "%FU_CHOICE%"=="B" goto MAIN_MENU
timeout /t 1 >nul
goto FILE_UTILITIES

:: ============================================================
::  SETTINGS
:: ============================================================
:SETTINGS
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                       SETTINGS                            ^|
echo  +-----------------------------------------------------------+
echo  ^|                                                           ^|
echo  ^|   Color Themes:                                           ^|
echo  ^|   [1]  Green   (hacker)                                   ^|
echo  ^|   [2]  Cyan    (default - ice blue)                       ^|
echo  ^|   [3]  Yellow  (amber terminal)                           ^|
echo  ^|   [4]  White   (clean)                                    ^|
echo  ^|   [5]  Red     (danger mode)                              ^|
echo  ^|                                                           ^|
echo  ^|   [6]  About Serium                                       ^|
echo  ^|   [B]  Back to Main Menu                                  ^|
echo  ^|                                                           ^|
echo  +-----------------------------------------------------------+
echo.
set /p SET_CHOICE="  >> Enter your choice: "

if "%SET_CHOICE%"=="1" ( color 0A & goto SETTINGS )
if "%SET_CHOICE%"=="2" ( color 0B & goto SETTINGS )
if "%SET_CHOICE%"=="3" ( color 0E & goto SETTINGS )
if "%SET_CHOICE%"=="4" ( color 0F & goto SETTINGS )
if "%SET_CHOICE%"=="5" ( color 0C & goto SETTINGS )
if "%SET_CHOICE%"=="6" goto ABOUT
if /i "%SET_CHOICE%"=="B" goto MAIN_MENU
goto SETTINGS

:ABOUT
cls
echo.
echo  +==============================================================+
echo  ^|                    ABOUT SERIUM                              ^|
echo  +==============================================================+
echo  ^|                                                              ^|
echo  ^|   Project:   Serium Multitool                                ^|
echo  ^|   Version:   1.0                                             ^|
echo  ^|   Type:      Windows Batch Utility                           ^|
echo  ^|                                                              ^|
echo  ^|   Features:                                                  ^|
echo  ^|   - App Launcher     Launch any installed application        ^|
echo  ^|   - Session Restore  Reopen apps from your last session      ^|
echo  ^|   - Batch Manager    Browse, run, edit, create .bat files    ^|
echo  ^|   - System Tools     Info, cleanup, shutdown, and more       ^|
echo  ^|   - Network Tools    Ping, trace, DNS, IP config             ^|
echo  ^|   - File Utilities   Open folders and search files           ^|
echo  ^|   - Settings         Themes and customization                ^|
echo  ^|                                                              ^|
echo  ^|        "Control everything from one place."                  ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.
echo  Press any key to return...
pause >nul
goto SETTINGS

:: ============================================================
::  SHARED HEADER
:: ============================================================
:HEADER
echo  +==============================================================+
echo  ^|   ##  SERIUM MULTITOOL  v1.0      [ Your Command Hub ]      ^|
echo  +==============================================================+
goto :EOF

:: ============================================================
::  WRITE STATUS  -  exports live data for the web UI
:: ============================================================
:WRITE_STATUS
set STATUS_FILE=%~dp0serium_v2_status.json
set SES_COUNT=0
set SESSION_FILE=%~dp0serium_session.txt
if exist "!SESSION_FILE!" (
    for /f "usebackq delims=" %%A in ("!SESSION_FILE!") do (
        set /a SES_COUNT+=1
    )
)
(
    echo {
    echo   "version": "1.5",
    echo   "tool": "Serium Multitool",
    echo   "session_count": !SES_COUNT!,
    echo   "timestamp": "%DATE% %TIME%"
    echo }
) > "!STATUS_FILE!"
goto :EOF

:: ============================================================
::  WEB CONTROL PANEL
:: ============================================================
:WEB_UI
cls
call :HEADER
echo.
echo  +-----------------------------------------------------------+
echo  ^|                  WEB CONTROL PANEL                        ^|
echo  +-----------------------------------------------------------+
echo  ^|   Starting Serium Web UI...                               ^|
echo  +-----------------------------------------------------------+
echo.
call :WRITE_STATUS

set CMD_FILE=%~dp0serium_commands.txt
set SERVER_PY=%~dp0serium_server.py

python --version >nul 2>&1
if errorlevel 1 (
    echo  [!!] Python not found. Get it at: https://www.python.org/downloads/
    pause & goto MAIN_MENU
)
if not exist "!SERVER_PY!" (
    echo  [!!] serium_server.py not found in: %~dp0
    pause & goto MAIN_MENU
)

echo  [OK] Starting server on http://localhost:8888 ...
start "" /b python "!SERVER_PY!"
timeout /t 2 >nul
start "" "http://localhost:8888"
echo.
echo  +-----------------------------------------------------------+
echo  ^|   Web UI open. Listening for browser commands.            ^|
echo  ^|   Press CTRL+C to stop and return to menu.               ^|
echo  +-----------------------------------------------------------+
echo.

:WEB_CMD_LOOP
timeout /t 3 >nul
if not exist "!CMD_FILE!" goto WEB_CMD_LOOP

set CMD_LINE=
for /f "usebackq delims=" %%C in ("!CMD_FILE!") do (
    if not defined CMD_LINE set "CMD_LINE=%%C"
)
del /f /q "!CMD_FILE!" 2>nul
if not defined CMD_LINE goto WEB_CMD_LOOP
echo  [>>] Command: !CMD_LINE!

if /i "!CMD_LINE!"=="LAUNCH:chrome"    ( start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:notepadpp" ( start "" "C:\Program Files\Notepad++\notepad++.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:vscode"    ( start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:explorer"  ( start explorer )
if /i "!CMD_LINE!"=="LAUNCH:calc"      ( start calc )
if /i "!CMD_LINE!"=="LAUNCH:paint"     ( start mspaint )
if /i "!CMD_LINE!"=="LAUNCH:snip"      ( start snippingtool )
if /i "!CMD_LINE!"=="LAUNCH:taskmgr"   ( start taskmgr )
if /i "!CMD_LINE!"=="LAUNCH:nvidia"    ( start "" "%LOCALAPPDATA%\NVIDIA Corporation\NVIDIA app\CEF\nvidia_app.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:spotify"   ( start "" "%APPDATA%\Spotify\Spotify.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:discord"   ( start "" "%LOCALAPPDATA%\Discord\Update.exe" --processStart Discord.exe 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:xbox"      ( start xbox )
if /i "!CMD_LINE!"=="LAUNCH:steam"     ( start "" "C:\Program Files (x86)\Steam\steam.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:ubisoft"   ( start "" "C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\UbisoftConnect.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:wireshark" ( start "" "C:\Program Files\Wireshark\Wireshark.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:putty"     ( start "" "C:\Program Files\PuTTY\putty.exe" 2>nul )
if /i "!CMD_LINE!"=="LAUNCH:portmaster"( start "" "C:\Program Files\Portmaster\portmaster.exe" 2>nul )
if /i "!CMD_LINE!"=="SYS:temp"         ( del /q /f /s "%TEMP%\*" 2>nul )
if /i "!CMD_LINE!"=="SYS:taskmgr"      ( start taskmgr )
if /i "!CMD_LINE!"=="SYS:devmgmt"      ( start devmgmt.msc )
if /i "!CMD_LINE!"=="NET:flushdns"     ( ipconfig /flushdns )
if /i "!CMD_LINE!"=="NET:ipconfig"     ( start cmd /k ipconfig /all )
if /i "!CMD_LINE!"=="FILE:desktop"     ( start explorer "%USERPROFILE%\Desktop" )
if /i "!CMD_LINE!"=="FILE:downloads"   ( start explorer "%USERPROFILE%\Downloads" )
if /i "!CMD_LINE!"=="FILE:documents"   ( start explorer "%USERPROFILE%\Documents" )
if /i "!CMD_LINE!"=="FILE:thispc"      ( start explorer shell:MyComputerFolder )
echo !CMD_LINE! | findstr /i "^FILE:folder:" >nul
if not errorlevel 1 ( set FPATH=!CMD_LINE:FILE:folder:=! & start explorer "!FPATH!" )
echo !CMD_LINE! | findstr /i "^FILE:open:" >nul
if not errorlevel 1 ( set FOPEN=!CMD_LINE:FILE:open:=! & start "" "!FOPEN!" 2>nul )
echo !CMD_LINE! | findstr /i "^BAT:run:" >nul
if not errorlevel 1 ( set BPATH=!CMD_LINE:BAT:run:=! & if exist "!BPATH!" call "!BPATH!" )
if /i "!CMD_LINE!"=="STATUS"           ( call :WRITE_STATUS )
if /i "!CMD_LINE!"=="EXIT_WEB"         ( goto MAIN_MENU )
call :WRITE_STATUS
goto WEB_CMD_LOOP

:: ============================================================
::  EXIT  -  close
:: ============================================================
:EXIT
cls
echo.
echo  +==============================================================+
echo  ^|                                                              ^|
echo  ^|          Thanks for using Serium Multitool.                  ^|
echo  ^|              Session saved. See you next time.               ^|
echo  ^|                                                              ^|
echo  +==============================================================+
echo.
timeout /t 2 >nul
exit
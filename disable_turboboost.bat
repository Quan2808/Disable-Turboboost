@echo off

REM Check for administrator privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrative privileges. Please run it as an administrator.
    pause
    exit
)

REM 1. Backup Registry
echo Backing up the registry before making changes...
set BACKUP_PATH="%USERPROFILE%\Desktop\RegistryBackup.reg"
reg export "HKEY_LOCAL_MACHINE\SYSTEM" %BACKUP_PATH% /y

if %errorLevel% neq 0 (
    echo Failed to back up the registry. Please check your permissions and try again.
    pause
    exit
)

echo Registry has been successfully backed up to your Desktop as RegistryBackup.reg.
pause

REM 2. Registry path to disable Turbo Boost
set REG_PATH="HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7"

REM 3. Change the value of Attributes to 2
reg add %REG_PATH% /v Attributes /t REG_DWORD /d 2 /f

REM 4. Confirmation message for Turbo Boost
echo Turbo Boost has been successfully disabled.

REM 5. Open Edit Plan Settings in Power Options
start control /name Microsoft.PowerOptions /page pagePlanSettings

REM 6. User instructions
echo.
echo ================================
echo      Configuration Instructions
echo ================================
echo     To complete the configuration, please follow these steps:
echo     1. Select "Change advanced power settings".
echo     2. Locate "Processor power management" and expand it.
echo     3. Select "Processor performance boost mode".
echo     4. For both "On battery" and "Plugged in", select "Disable".
echo.
pause

REM 7. End message
echo Configuration completed. Please close the Power Options window when done.
pause

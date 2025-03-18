@echo off
REM Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges.
    echo Please run as administrator.
    pause
    exit /b
)

REM Enable WSL feature
echo Enable Microsoft-Windows-Subsystem-Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

REM Enable Virtual Machine Platform feature
echo Enable VirtualMachinePlatform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

REM Restart to apply changes
echo Do you want to restart the computer now? (y/n)
set /p choice=
if /i "%choice%"=="y" (
    shutdown /r /t 0
) else (
    echo Restart canceled. Please restart manually to apply changes.
)

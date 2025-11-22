@echo off
echo ========================================
echo Flutter Windows Connection Fix
echo ========================================
echo.

REM Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script needs Administrator rights!
    echo.
    echo Right-click this file and select "Run as administrator"
    pause
    exit /b 1
)

echo [1/5] Stopping Flutter processes...
taskkill /F /IM flutter.exe /T >nul 2>&1
taskkill /F /IM dart.exe /T >nul 2>&1
timeout /t 2 /nobreak >nul
echo    Done!

echo.
echo [2/5] Cleaning Flutter cache...
call flutter clean >nul 2>&1
echo    Done!

echo.
echo [3/5] Getting dependencies...
call flutter pub get >nul 2>&1
echo    Done!

echo.
echo [4/5] Checking Flutter installation...
call flutter doctor >nul 2>&1
if %errorLevel% equ 0 (
    echo    Flutter is working!
) else (
    echo    WARNING: Flutter may have issues
)

echo.
echo [5/5] Checking devices...
call flutter devices
echo.

echo ========================================
echo IMPORTANT NEXT STEPS:
echo ========================================
echo.
echo 1. Open Windows Security
echo 2. Go to Virus ^& threat protection
echo 3. Click Manage settings
echo 4. Add these folders to Exclusions:
echo    - Your Flutter SDK folder (e.g., C:\src\flutter)
echo    - C:\Users\stani\aprojects\saveon_frontend
echo.
echo 5. Then run: flutter run -d windows
echo.
echo ========================================
pause



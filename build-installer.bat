@echo off
setlocal

echo ============================================
echo  Delphi Dependency Visualizer -- Installer
echo ============================================
echo.

set "ISCC=%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" set "ISCC=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" set "ISCC=C:\Program Files\Inno Setup 6\ISCC.exe"

if not exist "%ISCC%" (
    echo FEHLER: Inno Setup 6 nicht gefunden.
    echo Bitte installieren: winget install JRSoftware.InnoSetup
    exit /b 1
)

echo [1/2] Erstelle Self-Contained-Build...
call "%~dp0publish.bat"
if not exist "%~dp0publish\DelphiVisualizer.exe" (
    echo FEHLER beim Publish-Schritt.
    exit /b 1
)

echo.
echo [2/2] Erstelle Installer...
if not exist "%~dp0installer" mkdir "%~dp0installer"
"%ISCC%" "%~dp0setup.iss"
if errorlevel 1 (
    echo FEHLER beim Erstellen des Installers.
    exit /b 1
)

echo.
echo ============================================
echo  Fertig: installer\DelphiVisualizer-1.0-Setup.exe
echo ============================================
endlocal

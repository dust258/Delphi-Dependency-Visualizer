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

REM Version aus .csproj lesen
for /f "usebackq delims=" %%v in (`powershell -NoProfile -Command "(([xml](Get-Content '%~dp0DelphiVisualizer\DelphiVisualizer.csproj')).Project.PropertyGroup.Version)"`) do set VERSION=%%v

if "%VERSION%"=="" (
    echo FEHLER: Version konnte nicht aus .csproj gelesen werden.
    exit /b 1
)

echo Version: %VERSION%
echo.

echo [1/2] Erstelle Self-Contained-Build...
call "%~dp0publish.bat"
if not exist "%~dp0publish\DelphiVisualizer.exe" (
    echo FEHLER beim Publish-Schritt.
    exit /b 1
)

echo.
echo [2/2] Erstelle Installer...
if not exist "%~dp0installer" mkdir "%~dp0installer"
"%ISCC%" /DMyAppVersion=%VERSION% "%~dp0setup.iss"
if errorlevel 1 (
    echo FEHLER beim Erstellen des Installers.
    exit /b 1
)

echo.
echo ============================================
echo  Fertig: installer\DelphiVisualizer-%VERSION%-Setup.exe
echo ============================================
endlocal

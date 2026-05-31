@echo off
echo ============================================
echo  Delphi Dependency Visualizer - Build
echo ============================================

REM Check for .NET SDK
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo FEHLER: .NET SDK nicht gefunden!
    echo Bitte installieren mit:
    echo   winget install Microsoft.DotNet.SDK.8
    echo Oder von: https://dotnet.microsoft.com/download
    pause
    exit /b 1
)

echo .NET SDK gefunden:
dotnet --version

echo.
echo Baue Projekt...
dotnet build DelphiVisualizer\DelphiVisualizer.csproj -c Release

if errorlevel 1 (
    echo.
    echo BUILD FEHLGESCHLAGEN
    pause
    exit /b 1
)

echo.
echo ============================================
echo  BUILD ERFOLGREICH
echo  Starte Anwendung...
echo ============================================
start "" "DelphiVisualizer\bin\Release\net8.0-windows\DelphiVisualizer.exe"

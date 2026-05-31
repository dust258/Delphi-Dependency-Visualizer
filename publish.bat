@echo off
echo ============================================
echo  Delphi Dependency Visualizer - Publish
echo ============================================

dotnet publish DelphiVisualizer\DelphiVisualizer.csproj ^
  -c Release ^
  -r win-x64 ^
  --self-contained true ^
  -p:PublishSingleFile=true ^
  -o publish\

if errorlevel 1 (
    echo PUBLISH FEHLGESCHLAGEN
    pause
    exit /b 1
)

echo.
echo ============================================
echo  FERTIG: publish\DelphiVisualizer.exe
echo ============================================
explorer publish\

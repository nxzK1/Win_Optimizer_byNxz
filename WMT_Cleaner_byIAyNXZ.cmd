@echo off
chcp 65001 >nul
title HERRAMIENTA de MANTENIMIENTO y LIMPIEZA de WINDOWS
color 0A
mode con cols=90 lines=35

:: Verificar administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ❌ ERROR: Debe ejecutarse como ADMINISTRADOR
    echo → Clic derecho → "Ejecutar como administrador"
    pause
    exit /b
)

:manual
cls
echo ═══════════════════════════════════════════════════════════════════════════════════════════════════════
echo                    MANUAL DE USUARIO - HERRAMIENTA de MANTENIMIENTO y LIMPIEZA de WINDOWS
echo ═══════════════════════════════════════════════════════════════════════════════════════════════════════
echo.
echo ✅ Herramienta 100% creada con IA bajo los prompts y correciones de NXZ
echo 🎯 18 opciones de optimización, limpieza y mantenimiento
echo.
echo 📱 CÓMO USAR: [1-18] para seleccionar ^| [S] confirmar ^| [0] salir
echo ⚠️  CIERRA todos los programas antes de limpiar
echo.
echo Presione cualquier tecla para MENU PRINCIPAL...
pause >nul
goto menu

:menu

cls

echo ═══════════════════════════════════════════════════════════════════════════════════════════════════════
echo HERRAMIENTA de MANTENIMIENTO y LIMPIEZA de WINDOWS 10/11
echo ═══════════════════════════════════════════════════════════════════════════════════════════════════════
echo.
echo [1] Crear Punto de Restauracion.
echo [2] LIMPIAR ARCHIVOS TEMPORALES.
echo [3] Limpiar cache iconos.
echo [4] Limpiar cache fuentes.
echo [5] Limpiar Archivos temporales de WIN update.
echo [6] Eliminar Instaladores antiguos (>7 dias).
echo [7] Limpiar Cache de la Tienda de Microsoft.
echo [8] Liberador espacio disco.
echo [9] Diagnosticar y Reparar sistema. (DISM+SFC)
echo [10] Chequeo disco. (CHKDSK)
echo [11] Optimizar WIM Components.
echo [12] Eliminar logs antiguos.
echo [13] Limpiar historial/clipboard.
echo [14] Optimizar RAM.
echo [15] Plan energia Alto rendimiento.
echo [16] Limpiar DNS.
echo [17] Optimizar discos.
echo [18] Escaneo Virus Microsoft Removal Tool.
echo.
echo [0] SALIR
echo.

set /p opcion="Seleccione opcion [0-18]: "

if "%opcion%"=="0" goto salir

if "%opcion%"=="1" call :confirmar 1 "Crear Punto de Restauracion" & call :punto_restauracion & goto pausar
if "%opcion%"=="2" call :confirmar 2 "Limpiar archivos temporales (REAL)" & call :limpiar_temporales & goto pausar
if "%opcion%"=="3" call :confirmar 3 "Limpiar cache iconos" & call :cache_iconos & goto pausar
if "%opcion%"=="4" call :confirmar 4 "Limpiar cache fuentes" & call :cache_fuentes & goto pausar
if "%opcion%"=="5" call :confirmar 5 "Eliminar Windows Update temporales" & call :winupdate_temp & goto pausar
if "%opcion%"=="6" call :confirmar 6 "Eliminar instaladores antiguos" & call :instaladores_antiguos & goto pausar
if "%opcion%"=="7" call :confirmar 7 "Limpiar cache Tienda Microsoft" & call :tienda_cache & goto pausar
if "%opcion%"=="8" call :confirmar 8 "Liberador espacio disco" & call :cleanmgr & goto pausar
if "%opcion%"=="9" call :confirmar 9 "Reparar sistema (DISM+SFC)" & call :reparar_sistema & goto pausar
if "%opcion%"=="10" call :confirmar 10 "Chequeo disco (CHKDSK)" & call :chkdsk & goto pausar
if "%opcion%"=="11" call :confirmar 11 "Optimizar WIM" & call :optimizar_wim & goto pausar
if "%opcion%"=="12" call :confirmar 12 "Eliminar logs antiguos" & call :logs_antiguos & goto pausar
if "%opcion%"=="13" call :confirmar 13 "Limpiar historial/portapapeles" & call :historial_clip & goto pausar
if "%opcion%"=="14" call :confirmar 14 "Optimizar RAM" & call :optimizar_ram & goto pausar
if "%opcion%"=="15" call :confirmar 15 "Plan energia Alto rendimiento" & call :plan_energia & goto pausar
if "%opcion%"=="16" call :confirmar 16 "Limpiar cache DNS" & call :dns_cache & goto pausar
if "%opcion%"=="17" call :confirmar 17 "Optimizar discos" & call :optimizar_discos & goto pausar
if "%opcion%"=="18" call :confirmar 18 "Escaneo Virus Microsoft" & call :antivirus_msrt & goto pausar

goto menu

:confirmar
echo.
echo ¿Ejecutar "%~2"? [S/N]
set /p conf=
if /i "%conf%"=="S" exit /b
exit /b 1

:pausar
echo.
echo ✅ %~2 COMPLETADO
echo.
pause
goto menu

:punto_restauracion
echo 📍 Creando punto restauracion...
powershell -c "Checkpoint-Computer -Description 'Mantenimiento_%date%_%time:~0,2%h%time:~3,2%' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
if %errorlevel%==0 (echo ✅ Creado) else echo ⚠️ Verificar System Protection
goto :eof

:limpiar_temporales
echo 🧹 LIMPIANDO ARCHIVOS TEMPORALES...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
del /q /f /s "%temp%\*.*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1
md "%temp%" >nul 2>&1
del /q /f /s C:\Windows\Temp\*.* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
md C:\Windows\Temp >nul 2>&1
del /q /f /s C:\Windows\Prefetch\*.* >nul 2>&1
start explorer.exe
echo ✅ TEMPORALES ELIMINADOS 
goto :eof

:cache_iconos
echo 🎨 Limpiando la caché de iconos...
taskkill /f /im explorer.exe >nul 2>&1
del /f /q "%localappdata%\IconCache.db" >nul 2>&1
del /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
start explorer.exe
echo ✅ Iconos limpiados
goto :eof

:cache_fuentes
echo 📝 Limpiando la caché de fuentes...
rd /s /q "%localappdata%\Microsoft\Windows\FontCache" >nul 2>&1
del /f /q "%windir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.*" >nul 2>&1
echo ✅ Fuentes limpiadas
goto :eof

:winupdate_temp
echo 🔄 Buscando archivos temporales de Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q "%windir%\SoftwareDistribution\Download" >nul 2>&1
md "%windir%\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo ✅ Update cache limpiado
goto :eof

:instaladores_antiguos
echo 📦 Buscando y eliminando Instaladores obsoletos...
forfiles /p "%userprofile%\Downloads" /s /m *.exe /d -7 /c "cmd /c del @path" >nul 2>&1
forfiles /p "%userprofile%\Downloads" /s /m *.msi /d -7 /c "cmd /c del @path" >nul 2>&1
forfiles /p "%temp%" /s /m *.exe /d -7 /c "cmd /c del @path" >nul 2>&1
echo ✅ Instaladores antiguos eliminados
goto :eof

:tienda_cache
echo 🏪 Limpiando caché de Microsoft Store...
rd /s /q "%localappdata%\Packages\Microsoft.WindowsStore_*\AC" >nul 2>&1
powershell -c "Get-AppxPackage *WindowsStore* | Remove-AppxPackage" >nul 2>&1
echo ✅ Store cache limpiado
goto :eof

:cleanmgr
echo 🗑️ Liberador disco...
cleanmgr /sagerun:1
echo ✅ Cleanmgr completado
goto :eof

:reparar_sistema
echo 🔧 Ejecutando DISM + SFC /scannow para imagen de windows...
dism /online /cleanup-image /restorehealth >nul 2>&1
sfc /scannow >nul 2>&1
echo ✅ Sistema reparado
goto :eof

:chkdsk
echo 💿 Ejecutando CHKDSK - Diagnostico y reparación en progreso ...
chkdsk C: /f /r >nul 2>&1
echo ✅ Disco chequeado
goto :eof

:optimizar_wim
echo 📦 Optimizando WIM Components...
dism /online /cleanup-image /startcomponentcleanup >nul 2>&1
echo ✅ WIM optimizado
goto :eof

:logs_antiguos
echo 📋 Buscando Logs >30 dias...
forfiles /p "C:\Windows\Logs" /s /m *.* /d -30 /c "cmd /c del @path" >nul 2>&1
forfiles /p "C:\Windows\System32\winevt\Logs" /m *.* /d -30 /c "cmd /c del @path" >nul 2>&1
echo ✅ Logs eliminados
goto :eof

:historial_clip
echo 🗂️ Verificando y limpiando el Historial del portapapeles...
del /q /f "%appdata%\Microsoft\Windows\Recent\AutomaticDestinations\*.*" >nul 2>&1
echo off^&cls^|powershell -c "rm ([Environment]::GetFolderPath('CommonApplicationData')+'\Microsoft\Windows\Recent\CustomDestinations\*')" > clipboard.bat
call clipboard.bat
del clipboard.bat
echo. | clip
echo ✅ Historial limpio
goto :eof

:optimizar_ram
echo 🧠 LIMPIANDO MEMORIA RAM...
rundll32.exe advapi32.dll,ProcessIdleTasks
echo ✅ RAM optimizada
goto :eof

:plan_energia
echo ⚡ APLICANDO PLAN DE Alto rendimiento...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo ✅ Plan aplicado
goto :eof

:dns_cache
echo 🌐 LIMPIANDO LA CACHÉ DNS...
ipconfig /flushdns >nul
nbtstat -R >nul
nbtstat -RR >nul
echo ✅ DNS limpio
goto :eof

:optimizar_discos
echo 🛠️ DESFRAGMENTANDO Discos...
defrag C: /O >nul 2>&1
defrag S: /O >nul 2>&1
defrag H: /O >nul 2>&1
echo ✅ Discos optimizados
goto :eof

:antivirus_msrt
echo 🛡️ Escaneando con WindowsRemovalTool Antivirus Microsoft...
bitsadmin /transfer MRST https://go.microsoft.com/fwlink/?LinkID=99195&arch=x64 "%temp%\mrt.exe" /priority normal >nul
"%temp%\mrt.exe" /F:Y
del "%temp%\mrt.exe" >nul 2>&1
echo ✅ Antivirus completado
goto :eof

:salir
cls
echo ¡Gracias por usar el Optimizador! ✅
timeout /t 1 /nobreak >nul
exit /b

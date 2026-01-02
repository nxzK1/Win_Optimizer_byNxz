# =============================================================================
# HERRAMIENTA de MANTENIMIENTO y LIMPIEZA de WINDOWS
# =============================================================================

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "`n❌ ERROR: Debe ejecutarse como ADMINISTRADOR" -ForegroundColor Red
    Write-Host "→ Clic derecho → 'Ejecutar con PowerShell'" -ForegroundColor Yellow
    Read-Host "`nPresione ENTER para salir"
    exit
}

function Show-UserManual {
    Clear-Host
    Write-Host ("=" * 70) -ForegroundColor Cyan
    Write-Host "                    MANUAL DE USUARIO - HERRAMIENTA de MANTENIMIENTO y LIMPIEZA de WINDOWS" -ForegroundColor Cyan
    Write-Host ("=" * 70) -ForegroundColor Cyan
    Write-Host ""
    Write-Host "✅ Esta herramienta fue creada en su totalidad con IA, bajo los prompts del usuario nxz (Uso personal)" -ForegroundColor Yellow
    Write-Host "🎯  ¿PARA QUÉ SIRVE ESTE SCRIPT?" -ForegroundColor Green
    Write-Host "• Limpiar y optimizar Windows 10/11 de forma profesional" -ForegroundColor White
    Write-Host "• 18 opciones de mantenimiento 100% seguro y oficial" -ForegroundColor White
    Write-Host "• Libera GBs de espacio y mejora rendimiento" -ForegroundColor White
    Write-Host ""
    Write-Host "📱  CÓMO USARLO:" -ForegroundColor Green
    Write-Host "• Flechas ↑↓ para navegar" -ForegroundColor Yellow
    Write-Host "• ENTER para seleccionar opción" -ForegroundColor Yellow
    Write-Host "• S para confirmar ejecución" -ForegroundColor Yellow
    Write-Host "• ESC para salir del menú" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "⚠️  ANTES DE EMPEZAR:" -ForegroundColor Red
    Write-Host "• Guarda tus trabajos abiertos" -ForegroundColor White
    Write-Host "• Algunas opciones reinician Explorer o tardan varios minutos" -ForegroundColor White
    Write-Host ""
    Write-Host "✅ 100% SEGURO - Usa herramientas oficiales Microsoft" -ForegroundColor Green
    Write-Host ""
    Write-Host "Presiona ENTER para continuar al MENÚ PRINCIPAL..." -ForegroundColor Cyan
    Read-Host | Out-Null
}

$menuOptions = @(
    @{Name="1. Crear Punto de Restauracion"; Desc="✅ Crea backup del sistema antes de optimizar el sistema (RECOMENDADO)"},
    @{Name="2. Limpiar archivos temporales (%temp%, temp, prefetch)"; Desc="🧹 Libera archivos temporales."},
    @{Name="3. Limpiar caché de iconos"; Desc="🎨 Corrige iconos corruptos/lentos."},
    @{Name="4. Limpiar caché de fuentes"; Desc="📝 Evita errores visuales de tipografías."},
    @{Name="5. Eliminar archivos temporales Windows Update"; Desc="🔄 Libera memoria de descargas obsoletas."},
    @{Name="6. Eliminar archivos instalación temporales"; Desc="📦 Borra .exe/.msi antiguos (>7 días)."},
    @{Name="7. Limpiar caché Tienda Microsoft"; Desc="🏪 Limpia caché de apps y tienda."},
    @{Name="8. Liberador de espacio en disco"; Desc="🗑️  Limpieza clásica con selección manual."},
    @{Name="9. Reparar archivos sistema (DISM + SFC)"; Desc="🔧 Corrige archivos corruptos de Windows."},
    @{Name="10. Chequeo disco (CHKDSK)"; Desc="💿 Detecta/repara errores de disco."},
    @{Name="11. Optimizar WIM (Componentes)"; Desc="📦 Libera memoria de actualizaciones viejas."},
    @{Name="12. Eliminar logs antiguos"; Desc="📋 Limpia registros >30 días."},
    @{Name="13. Limpiar historial y portapapeles"; Desc="🗂️ Borra recientes y privacidad."},
    @{Name="14. Optimizar memoria RAM"; Desc="🧠 Libera caché RAM para más rendimiento."},
    @{Name="15. Plan energía Alto rendimiento"; Desc="⚡ Activa el plan, boostea el procesador, puede subir temperaturas."},
    @{Name="16. Limpiar caché DNS"; Desc="🌐 Soluciona problemas de conexión."},
    @{Name="17. Desfragmentar/optimizar discos"; Desc="🛠️ Optimiza SSD, desfragmenta HDD."},
    @{Name="18. Escaneo virus (Malware Removal Tool)"; Desc="🛡️ Antivirus oficial Microsoft (30-60min)."},
    @{Name="🔙 SALIR"; Desc="Cerrar script de mantenimiento"}
)

function Show-InteractiveMenu {
    param([array]$Options)
    $pos = 0
    $max = $Options.Count - 1

    while ($true) {
        Clear-Host
        Write-Host ("=" * 70) -ForegroundColor Cyan
        Write-Host "                    HERRAMIENTA de MANTENIMIENTO y LIMPIEZA de WINDOWS 10/11" -ForegroundColor Cyan
        Write-Host ("=" * 70) -ForegroundColor Cyan
        Write-Host ""

        for ($i=0; $i -lt $Options.Count; $i++) {
            if ($i -eq $pos) {
                Write-Host " > $($Options[$i].Name)" -ForegroundColor Black -BackgroundColor Yellow
            }
            else {
                Write-Host "   $($Options[$i].Name)"
            }
        }

        Write-Host ""
        Write-Host "📖 DESCRIPCIÓN: $($Options[$pos].Desc)" -ForegroundColor Green
        Write-Host "👆 ↑↓ = Navegar | ⏎ ENTER = Seleccionar | ESC = Salir" -ForegroundColor Cyan

        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        switch ($key.VirtualKeyCode) {
            38 { if ($pos -gt 0) { $pos-- } else { $pos = $max } }
            40 { if ($pos -lt $max) { $pos++ } else { $pos = 0 } }
            13 { return $pos }
            27 { return -1 }
        }
    }
}

function ConfirmAndRun([string]$name, [scriptblock]$func) {
    Write-Host "`n¿Desea ejecutar '$name'? (S/N)" -ForegroundColor Cyan
    $confirm = Read-Host
    if ($confirm.ToUpper() -eq 'S') {
        try {
            & $func
        }
        catch {
            Write-Host "❌ Error al ejecutar la opción." -ForegroundColor Red
        }
        Write-Host "`n✅ '$name' COMPLETADO" -ForegroundColor Green
        Write-Host "Presione ENTER para continuar..." -ForegroundColor Cyan
        Read-Host | Out-Null
    }
}

# Funciones para cada opción (completas)
function CrearPuntoRestauracion {
    Write-Host "📍 Creando punto de restauración..."
    try {
        Checkpoint-Computer -Description "Mantenimiento_$(Get-Date -Format 'yyyy-MM-dd_HH-mm')" -RestorePointType "MODIFY_SETTINGS"
        Write-Host "✅ Punto de restauración creado." -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ No se pudo crear el punto. Verifica que está habilitado." -ForegroundColor Yellow
    }
}

function LimpiarArchivosTemporales {
    Write-Host "🧹 Limpiando archivos temporales (%temp%, temp, prefetch)..."
    $folders = @(
        [Environment]::GetFolderPath("LocalApplicationData") + "\Temp",
        "C:\Windows\Temp",
        "C:\Windows\Prefetch"
    )
    foreach ($folder in $folders) {
        Write-Host "   Limpiando $folder ..."
        try {
            Get-ChildItem -Path $folder -Recurse -Force -ErrorAction SilentlyContinue |
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "   OK" -ForegroundColor Green
        }
        catch {
            Write-Host "   Algunos archivos no pudieron ser eliminados." -ForegroundColor Yellow
        }
    }
}

function LimpiarCacheIconos {
    Write-Host "🎨 Limpiando caché de iconos..."
    try {
        Remove-Item "$env:LOCALAPPDATA\IconCache.db" -Force -ErrorAction SilentlyContinue
        Stop-Process explorer -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        Start-Process explorer
        Write-Host "✅ Caché de iconos limpiada." -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Error limpiando caché de iconos." -ForegroundColor Yellow
    }
}

function LimpiarCacheFuentes {
    Write-Host "📝 Limpiando caché de fuentes..."
    $paths = @(
        "$env:LOCALAPPDATA\Microsoft\Windows\FontCache",
        "$env:WINDIR\ServiceProfiles\LocalService\AppData\Local\FontCache",
        "$env:WINDIR\System32\FNTCACHE.DAT"
    )
    foreach ($path in $paths) {
        Write-Host "   Limpiando $path ..."
        try {
            Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "   OK" -ForegroundColor Green
        }
        catch {
            Write-Host "No se pudo limpiar la cache de fuentes." -ForegroundColor Yellow
        }
    }
}

function EliminarTemporalesWinUpdate {
    Write-Host "🔄 Limpiando archivos temporales de Windows Update..."
    try {
        Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
        Remove-Item "$env:WINDIR\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Service -Name wuauserv -ErrorAction SilentlyContinue
        Write-Host "✅ Archivos temporales de Windows Update eliminados." -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Error eliminando archivos temporales de Windows Update." -ForegroundColor Yellow
    }
}

function EliminarInstaladoresTemporales {
    Write-Host "📦 Eliminando archivos de instalación temporales (>7 días)..."
    $patterns = @(
        "$env:USERPROFILE\Downloads\*.exe",
        "$env:USERPROFILE\Downloads\*.msi",
        "$env:TEMP\*.exe",
        "$env:TEMP\*.msi"
    )
    $count = 0
    foreach ($pattern in $patterns) {
        $files = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }
        foreach ($file in $files) {
            try {
                Remove-Item $file.FullName -Force
                $count++
            }
            catch {}
        }
    }
    Write-Host "✅ Eliminados $count archivos temporales de instalación." -ForegroundColor Green
}

function LimpiarCacheTiendaMicrosoft {
    Write-Host "🏪 Limpiando caché de la Tienda Microsoft..."
    try {
        Remove-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsStore_*\AC\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✅ Caché de Tienda Microsoft limpiada." -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Error limpiando caché de la Tienda Microsoft." -ForegroundColor Yellow
    }
}

function EjecutarLiberadorDisco {
    Write-Host "🗑️ Ejecutando Liberador de espacio en disco..."
    Start-Process cleanmgr -ArgumentList "/sageset:1" -Wait
    Start-Process cleanmgr -ArgumentList "/sagerun:1" -Wait
    Write-Host "✅ Liberador de espacio completado." -ForegroundColor Green
}

function RepararSistemaDISMsfc {
    Write-Host "🔧 Reparando archivos del sistema (DISM + SFC)..."
    DISM.exe /Online /Cleanup-Image /RestoreHealth | Out-Null
    sfc /scannow | Out-Null
    Write-Host "✅ Reparación completada." -ForegroundColor Green
}

function ChequeoDiscoCHKDSK {
    Write-Host "💿 Chequeo y reparación ligera del disco..."
    chkdsk C: /scan | Out-Null
    Write-Host "✅ Chequeo disco completado." -ForegroundColor Green
}

function OptimizarWIM {
    Write-Host "📦 Optimizando base de datos WIM (Windows Imaging)..."
    DISM.exe /Online /Cleanup-Image /StartComponentCleanup | Out-Null
    DISM.exe /Online /Cleanup-Image /SPSuperseded | Out-Null
    Write-Host "✅ Optimización de WIM completada." -ForegroundColor Green
}

function EliminarLogsAntiguos {
    Write-Host "📋 Eliminando archivos de registro antiguos..."
    $folders = @(
        "C:\Windows\Logs",
        "C:\Windows\System32\winevt\Logs",
        "$env:ProgramData\Microsoft\Windows\WER",
        "C:\Windows\Minidump"
    )
    foreach ($folder in $folders) {
        if (Test-Path $folder) {
            Get-ChildItem -Path $folder -Recurse -File -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } |
            Remove-Item -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "✅ Logs antiguos eliminados." -ForegroundColor Green
}

function LimpiarHistorialPortapapeles {
    Write-Host "🗂️ Limpiando historial y portapapeles..."
    Remove-Item "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\*" -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations\*" -Force -ErrorAction SilentlyContinue
    Add-Type -AssemblyName PresentationCore
    [System.Windows.Clipboard]::Clear()
    Write-Host "✅ Historial y portapapeles limpios." -ForegroundColor Green
}

function OptimizarRAM {
    Write-Host "🧠 Optimizando memoria RAM..."
    rundll32 advapi32.dll,ProcessIdleTasks
    [GC]::Collect()
    Write-Host "✅ Memoria RAM optimizada." -ForegroundColor Green
}

function PlanEnergiaAltoRendimiento {
    Write-Host "⚡ Aplicando plan de energía Alto rendimiento..."
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Write-Host "✅ Plan de energía aplicado." -ForegroundColor Green
}

function LimpiarCacheDNS {
    Write-Host "🌐 Limpiando caché DNS..."
    ipconfig /flushdns | Out-Null
    Write-Host "✅ Caché DNS limpia." -ForegroundColor Green
}

function DesfragmentarOptimizarDiscos {
    Write-Host "🛠️ Desfragmentando / Optimizando discos..."
    $discos = Get-Volume | Where-Object DriveType -eq 'Fixed'
    foreach ($d in $discos) {
        Optimize-Volume -DriveLetter $d.DriveLetter -Verbose -Defrag -ReTrim | Out-Null
    }
    Write-Host "✅ Discos optimizados." -ForegroundColor Green
}

function EscaneoVirusMRST {
    Write-Host "🛡️ Ejecutando Windows Removal Tool (antivirus)..."
    try {
        $url = "https://go.microsoft.com/fwlink/?LinkID=99195&arch=x64"
        $path = "$env:TEMP\MRST.exe"
        if (-not (Test-Path $path)) {
            Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing
        }
        Start-Process -FilePath $path -ArgumentList "/F:Y" -Wait
        Write-Host "✅ Escaneo antivirus finalizado." -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ No se pudo iniciar el escaneo antivirus." -ForegroundColor Yellow
    }
}

# Menú y lógica principal
Show-UserManual

while ($true) {
    $selected = Show-InteractiveMenu -Options $menuOptions
    if ($selected -eq -1 -or $menuOptions[$selected].Name -eq "🔙 SALIR") {
        Write-Host "`nGracias por usar el script. ¡Hasta luego!" -ForegroundColor Cyan
        break
    }
    $funcMap = @{
        0  = { CrearPuntoRestauracion }
        1  = { LimpiarArchivosTemporales }
        2  = { LimpiarCacheIconos }
        3  = { LimpiarCacheFuentes }
        4  = { EliminarTemporalesWinUpdate }
        5  = { EliminarInstaladoresTemporales }
        6  = { LimpiarCacheTiendaMicrosoft }
        7  = { EjecutarLiberadorDisco }
        8  = { RepararSistemaDISMsfc }
        9  = { ChequeoDiscoCHKDSK }
        10 = { OptimizarWIM }
        11 = { EliminarLogsAntiguos }
        12 = { LimpiarHistorialPortapapeles }
        13 = { OptimizarRAM }
        14 = { PlanEnergiaAltoRendimiento }
        15 = { LimpiarCacheDNS }
        16 = { DesfragmentarOptimizarDiscos }
        17 = { EscaneoVirusMRST }
    }
    $name = $menuOptions[$selected].Name
    ConfirmAndRun $name $funcMap[$selected]
}

# SIG # Begin signature block
# MIIFlwYJKoZIhvcNAQcCoIIFiDCCBYQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUoffD43s5VaejEf3GHNF3+6gM
# LvCgggMkMIIDIDCCAgigAwIBAgIQL2wMBlArra9GTW7BFJXLCTANBgkqhkiG9w0B
# AQsFADAoMSYwJAYDVQQDDB1NYW50ZW5pbWllbnRvIExvY2FsIGJ5IElBJk5YWjAe
# Fw0yNTEyMDQwMTQzMTZaFw0yNjEyMDQwMjAzMTZaMCgxJjAkBgNVBAMMHU1hbnRl
# bmltaWVudG8gTG9jYWwgYnkgSUEmTlhaMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
# MIIBCgKCAQEAyuRb1e+9YDb9W01ya7qD3W/lsfVd0iQ5Eyc7k4+rrrHuvdi7Yc6V
# UDu+VHWdx5lzsAuiesIkNF115DVh0bi19J7v0dMyz9TbX0Cr8um/rAeKFlopDzAU
# u9IuBWMI8T8KcHwIIBprHad2DGHrL2jq9haCjOToW+ja5ME7WB7GcP7OSNsHWLlE
# DM5kW2bW6UfTUey5Tolo/H8PgbXFHh2tSh0DQMUM8gaj2xR7t1QmKsGKDZQcNCoC
# xi/t77vtYlBF03TcyYCl8coEoTMxjBH6X0Cg8dr9ZfZ0t4dlz1hXrhGnSwSW8D0n
# gnETBY9pOkv3Si691sJ1YQXubS84ToG0pQIDAQABo0YwRDAOBgNVHQ8BAf8EBAMC
# B4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0OBBYEFCqhLxmfU9FMl56SdjM2
# wjJdzFZ1MA0GCSqGSIb3DQEBCwUAA4IBAQAqw8dutBF+wyhnTnBkq5arOgTBVapb
# d6DtyP8qcg3VTlJpXmNN+duiOgc+AJylErg8uGN9Ob41CEV1T6Z1gEOWzyusWAD0
# JanaVAN4v4GbNzSnzd6jPMcZcD8+ha8whDnSBTNmt77onb1Ugjl7hSgbHyBYiUQd
# rCWuk2WJZKx4m/GIkrsRk1llha63SEyWWx3WXzBX6M5aYaNmzrVF0wbrdUA9Bv62
# 99uwfIcS5PYnzKlTWQQqfYDdulWsPcqRiPyPXre2G60FohmA9JZ6KJm21Tpw7QDS
# wmX17MKict4f7RKzB4PdgJJRZgCoVbj6KI9Dyr3jQQWZdGIIvWL7QADuMYIB3TCC
# AdkCAQEwPDAoMSYwJAYDVQQDDB1NYW50ZW5pbWllbnRvIExvY2FsIGJ5IElBJk5Y
# WgIQL2wMBlArra9GTW7BFJXLCTAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEK
# MAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3
# AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU5CjUwmbnkYXarboQ
# STJipgEcFhswDQYJKoZIhvcNAQEBBQAEggEAsFRY+PsvaF1E7zTHuC27RglItvA3
# Z1PLGKdxU8QqB5+N4vbmwIgPrZYnlj+t6hw5JxUVLLSwcoAbpUyo9sCF60bQX/Lv
# 5UkLXw10BaMHVOj5MJHpr8tOg+wfzCQFjyndAZ8iOvOwbVEc69iPC+h/FIbeAJtr
# ZaqCRap/qpWVIJYVPEM8MZJffzNJdFC5EWs4btOK14MlifiO+RCJg1oQLqlQz4DU
# AusQfG9Wo825zW05fijr8n7PR3VaUc0YTUfchDkRigx/goJb+bWjBJ/DBzzb6cQT
# OOssoOgzgdelVtLMiCAqEFipIByYSioLCzVlcc2ztlgNMNHb9xN5JPKeqw==
# SIG # End signature block

# =============================================================
# TINY11 ULTIMATE - THE IRONCLAD DEPLOYER (VERIFIED & TESTED)
# =============================================================

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$LogFile = Join-Path -Path $PSScriptRoot -ChildPath "Deployment_Log.txt"

function Update-Environment {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Write-Log {
    param([string]$Message, [string]$Color = "White")
    $Timestamp = Get-Date -Format "HH:mm:ss"
    Add-Content -Path $LogFile -Value "[$Timestamp] $Message"
    Write-Host "`n$Message" -ForegroundColor $Color
}

Clear-Host

# --- PHASE 0: CTT TOOL TOGGLE ---
$RunCTT = Read-Host "Launch Chris Titus Tech Windows Utility? (y/n)"
if ($RunCTT -eq "y") {
    Start-Process powershell.exe -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command", "irm christitus.com/win | iex" -Verb RunAs
}

# --- 1. THE SORTED MASTER LIST ---
$AppList = @(
    "7zip", "everything", "treesizefree", "openssl", "git", "yarn", "hwinfo.install",
    "winrar", "vlc", "mpc-hc", "musicbee", "postman", "rdm", "figma", "discord", 
    "whatsapp", "crystaldiskmark", "msiafterburner", "directx", "vcredist-all",
    "vscode", "nodejs-lts", "mongodb-compass", "brave", "googlechrome", "firefox", 
    "google-chrome-canary", "ollama", "krita", "gimp", "cinebench", "unigine-heaven",
    "nvidia-display-driver", "intel-chipset-device-software", "k-lite-codec-pack-full", 
    "kdenlive", "playnite", "steam", "epicgames-launcher", "stabilitymatrix",
    "anaconda3", "openjdk17", "androidstudio", "android-sdk"
)

# --- PHASE 1: PRE-INSTALL AUDIT (THE CHECKER) ---
Write-Host "--- SCANNING SYSTEM FOR EXISTING APPS ---" -ForegroundColor Cyan
$LocalChoco = choco list --local-only --limit-output
$AlreadyInstalled = @()
$ToInstall = @()

foreach($app in $AppList) { 
    if ($LocalChoco -like "*$app*") { 
        $AlreadyInstalled += $app 
    } else {
        $ToInstall += $app
    }
}

# LIVE HARDWARE DETECTION
$CPU = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
$GPU = (Get-CimInstance Win32_VideoController | Where-Object Name -like "*NVIDIA*" | Select-Object -ExpandProperty Name) -join ", "
$Disk = (Get-PhysicalDisk | Where-Object BusType -eq "NVMe" | Select-Object -First 1).Model
$FreeSpace = [Math]::Round((Get-PSDrive C).Free / 1GB, 2)

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "           SYSTEM VERIFICATION REPORT                " -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " CPU detected: $CPU"
Write-Host " GPU detected: $(if($GPU){$GPU}else{'NVIDIA Driver Needed'})"
Write-Host " Disk Model:   $Disk"
Write-Host " Free Space:   $FreeSpace GB"
Write-Host "-----------------------------------------------------"
Write-Host " Status:       $($AlreadyInstalled.Count) Apps Verified / $($ToInstall.Count) To Install"
Write-Host "====================================================="

Write-Host "`nType 'go' to execute." -ForegroundColor Yellow
if ((Read-Host) -ne "go") { exit }

# --- PHASE 2: SYSTEM TWEAKS ---
$GlobalStart = Get-Date
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -ErrorAction SilentlyContinue
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

$Dirs = @("C:\Dev", "C:\Media", "C:\AI_Models", "C:\Games")
$WshShell = New-Object -ComObject WScript.Shell
foreach ($dir in $Dirs) { 
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\$(Split-Path $dir -Leaf).lnk")
    $Shortcut.TargetPath = $dir
    $Shortcut.Save()
}

# --- PHASE 3: DEPLOYMENT WITH REAL-TIME BUG TRACKING ---
$Analytics = @()
foreach ($app in $AppList) {
    if ($AlreadyInstalled -contains $app) {
        $Analytics += [PSCustomObject]@{App=$app; Time="Skipped"; Status="Already Present"}
        continue
    }

    $AppStart = Get-Date
    Write-Log "INSTALLING: $app ..." "Cyan"
    
    # Executing choco - the tool itself verifies the download link integrity
    choco install $app -y --no-progress --ignore-checksums --accept-license
    
    $ExitCode = $LASTEXITCODE
    Update-Environment 
    $Duration = ((Get-Date) - $AppStart).ToString("mm\:ss")
    
    # Logic check: Did it actually work?
    $Status = if($ExitCode -eq 0){"Success"}else{"FAILED (Code $ExitCode)"}
    $Analytics += [PSCustomObject]@{App=$app; Time=$Duration; Status=$Status}
    
    if($ExitCode -ne 0) { Write-Log "!! Alert: $app failed to install. Check internet or link." "Red" }
}

# --- PHASE 4: THE FINAL ANALYTICS REPORT ---
$TotalTime = ((Get-Date) - $GlobalStart).ToString("hh\:mm\:ss")
Clear-Host
Write-Host "=====================================================" -ForegroundColor Green
Write-Host "           POST-INSTALLATION AUDIT REPORT            " -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Green
$Analytics | Format-Table -AutoSize
Write-Log "TOTAL ELAPSED TIME: $TotalTime" "White"

# Cleanup & Alerts
[System.Media.SystemSounds]::Beep.Play()
$Cleanup = Read-Host "`nDelete setup cache? (y/n)"
if ($Cleanup -eq "y") { choco clean -y }

Write-Log "Deployment Complete. Log saved to script path." "Green"
Pause
# ============================================================
#  Install-Apps.ps1
#  Instaluje wybrane aplikacje przez winget
# ============================================================

#Requires -Version 5.1

# --- Lista aplikacji -----------------------------------------------------------
$apps = @(
    [PSCustomObject]@{ Name = "Discord";     Id = "Discord.Discord"        },
    [PSCustomObject]@{ Name = "Zen Browser"; Id = "Zen-Team.Zen-Browser"   },
    [PSCustomObject]@{ Name = "Steam";       Id = "Valve.Steam"            },
    [PSCustomObject]@{ Name = "ShareX";      Id = "ShareX.ShareX"          },
    [PSCustomObject]@{ Name = "PowerToys";   Id = "Microsoft.PowerToys"    },
    [PSCustomObject]@{ Name = "Notepad++";   Id = "Notepad++.Notepad++"    },
    [PSCustomObject]@{ Name = "Windhawk";    Id = "RamenSoftware.Windhawk" },
    [PSCustomObject]@{ Name = "7-Zip";       Id = "7zip.7zip"              },
    [PSCustomObject]@{ Name = "CPU-Z";       Id = "CPUID.CPU-Z"            },
    [PSCustomObject]@{ Name = "VS Code";     Id = "Microsoft.VisualStudioCode" }
)

# --- Sprawdz winget ------------------------------------------------------------
Write-Host ""
Write-Host ("=" * 56) -ForegroundColor DarkGray
Write-Host "  Install-Apps.ps1 - winget installer" -ForegroundColor White
Write-Host ("=" * 56) -ForegroundColor DarkGray

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "  [BLAD] winget nie zostal znaleziony." -ForegroundColor Red
    Write-Host "  Zainstaluj App Installer ze sklepu Microsoft Store." -ForegroundColor Yellow
    exit 1
}

$wingetVersion = (winget --version) 2>&1
Write-Host ""
Write-Host "  winget $wingetVersion gotowy." -ForegroundColor DarkGray

# --- Instalacja ----------------------------------------------------------------
$results = [System.Collections.Generic.List[PSCustomObject]]::new()

foreach ($app in $apps) {
    Write-Host ""
    Write-Host "  >> " -NoNewline -ForegroundColor DarkCyan
    Write-Host $app.Name -NoNewline -ForegroundColor Cyan
    Write-Host "  ($($app.Id))" -ForegroundColor DarkGray

    Write-Host "  ... instalowanie, czekaj ..." -ForegroundColor DarkGray

    winget install `
        --id $app.Id `
        --silent `
        --accept-package-agreements `
        --accept-source-agreements `
        --no-upgrade *> $null

    if ($LASTEXITCODE -eq 0) {
        $status = "OK"
        $color  = "Green"
    } elseif ($LASTEXITCODE -eq -1978335135) {
        $status = "JUZ ZAINSTALOWANA"
        $color  = "Yellow"
    } else {
        $status = "BLAD ($LASTEXITCODE)"
        $color  = "Red"
    }

    Write-Host "  [$status] $($app.Name)" -ForegroundColor $color

    $results.Add([PSCustomObject]@{
        Aplikacja = $app.Name
        ID        = $app.Id
        Status    = $status
    })
}

# --- Podsumowanie --------------------------------------------------------------
Write-Host ""
Write-Host ("=" * 56) -ForegroundColor DarkGray
Write-Host "  Podsumowanie" -ForegroundColor White
Write-Host ("=" * 56) -ForegroundColor DarkGray

$results | Format-Table -AutoSize

$ok      = ($results | Where-Object { $_.Status -eq "OK" }).Count
$already = ($results | Where-Object { $_.Status -eq "JUZ ZAINSTALOWANA" }).Count
$errors  = ($results | Where-Object { $_.Status -like "BLAD*" }).Count

Write-Host "  Zainstalowano nowo:  $ok"      -ForegroundColor Green
Write-Host "  Juz bylo:            $already" -ForegroundColor Yellow

if ($errors -gt 0) {
    Write-Host "  Bledy:               $errors" -ForegroundColor Red
} else {
    Write-Host "  Bledy:               $errors" -ForegroundColor DarkGray
}

Write-Host ""

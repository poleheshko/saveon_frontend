# Diagnostic script to find why connection drops after 2 minutes
Write-Host "=== Flutter Connection Diagnostic ===" -ForegroundColor Cyan
Write-Host ""

# Check Windows Defender exclusions
Write-Host "[1/6] Checking Windows Defender Exclusions..." -ForegroundColor Green
$exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath -ErrorAction SilentlyContinue
if ($exclusions) {
    Write-Host "   Current exclusions:" -ForegroundColor Gray
    $flutterExcluded = $false
    $projectExcluded = $false
    foreach ($exclusion in $exclusions) {
        Write-Host "     - $exclusion" -ForegroundColor Gray
        if ($exclusion -like "*flutter*") { $flutterExcluded = $true }
        if ($exclusion -like "*saveon_frontend*") { $projectExcluded = $true }
    }
    if (-not $flutterExcluded) {
        Write-Host "   ⚠ WARNING: Flutter folder NOT in exclusions!" -ForegroundColor Red
    } else {
        Write-Host "   ✓ Flutter folder is excluded" -ForegroundColor Green
    }
    if (-not $projectExcluded) {
        Write-Host "   ⚠ WARNING: Project folder NOT in exclusions!" -ForegroundColor Red
    } else {
        Write-Host "   ✓ Project folder is excluded" -ForegroundColor Green
    }
} else {
    Write-Host "   ✗ NO EXCLUSIONS FOUND! This is likely the problem!" -ForegroundColor Red
    Write-Host "   You MUST add exclusions (see DETAILED_FIX_INSTRUCTIONS.md)" -ForegroundColor Yellow
}

# Check firewall rules
Write-Host ""
Write-Host "[2/6] Checking Windows Firewall Rules..." -ForegroundColor Green
$firewallRules = Get-NetFirewallRule -DisplayName "*Flutter*","*Dart*" -ErrorAction SilentlyContinue
if ($firewallRules) {
    Write-Host "   Found firewall rules:" -ForegroundColor Gray
    foreach ($rule in $firewallRules) {
        Write-Host "     - $($rule.DisplayName) ($($rule.Enabled))" -ForegroundColor Gray
    }
} else {
    Write-Host "   ⚠ No Flutter/Dart firewall rules found" -ForegroundColor Yellow
}

# Check for running Flutter processes
Write-Host ""
Write-Host "[3/6] Checking Flutter Processes..." -ForegroundColor Green
$flutterProcs = Get-Process -Name "flutter","dart" -ErrorAction SilentlyContinue
if ($flutterProcs) {
    Write-Host "   Running processes:" -ForegroundColor Gray
    foreach ($proc in $flutterProcs) {
        Write-Host "     - $($proc.Name) (PID: $($proc.Id))" -ForegroundColor Gray
    }
} else {
    Write-Host "   No Flutter processes running" -ForegroundColor Gray
}

# Check port usage
Write-Host ""
Write-Host "[4/6] Checking Common Flutter Ports..." -ForegroundColor Green
$ports = @(5037, 9100, 9101, 9102)
foreach ($port in $ports) {
    $portCheck = netstat -ano | Select-String ":$port "
    if ($portCheck) {
        Write-Host "   Port $port is in use" -ForegroundColor Gray
    }
}

# Check Windows Defender Real-time Protection
Write-Host ""
Write-Host "[5/6] Checking Windows Defender Status..." -ForegroundColor Green
try {
    $defenderStatus = Get-MpComputerStatus -ErrorAction SilentlyContinue
    if ($defenderStatus) {
        Write-Host "   Real-time protection: $($defenderStatus.RealTimeProtectionEnabled)" -ForegroundColor Gray
        if ($defenderStatus.RealTimeProtectionEnabled) {
            Write-Host "   ⚠ Real-time protection is ON - may be blocking connections" -ForegroundColor Yellow
        }
    }
} catch {
    Write-Host "   Could not check Defender status" -ForegroundColor Yellow
}

# Check Flutter version and doctor
Write-Host ""
Write-Host "[6/6] Checking Flutter Installation..." -ForegroundColor Green
try {
    $flutterVersion = flutter --version 2>&1 | Select-Object -First 1
    Write-Host "   $flutterVersion" -ForegroundColor Gray
    Write-Host ""
    Write-Host "   Running flutter doctor..." -ForegroundColor Gray
    flutter doctor -v 2>&1 | Select-Object -First 20
} catch {
    Write-Host "   ✗ Flutter not found in PATH" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== DIAGNOSIS COMPLETE ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "MOST LIKELY ISSUE: Windows Defender is blocking the connection" -ForegroundColor Yellow
Write-Host ""
Write-Host "SOLUTION:" -ForegroundColor Green
Write-Host "1. Open Windows Security (Windows Key + type 'Windows Security')" -ForegroundColor White
Write-Host "2. Virus & threat protection → Manage settings" -ForegroundColor White
Write-Host "3. Scroll to Exclusions → Add or remove exclusions" -ForegroundColor White
Write-Host "4. Add these folders:" -ForegroundColor White
Write-Host "   - Your Flutter SDK folder (find it with: where.exe flutter)" -ForegroundColor White
Write-Host "   - C:\Users\stani\aprojects\saveon_frontend" -ForegroundColor White
Write-Host ""
Write-Host "Then restart your Flutter app!" -ForegroundColor Cyan



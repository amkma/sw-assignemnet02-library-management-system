# =============================================================
# Library Management System — Windows Setup Script
# =============================================================
# Run this script in PowerShell from the project root:
#   cd path\to\library
#   .\setup.ps1
# =============================================================

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Library Management System — Setup" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# ─── Step 1: Check Java 21 ───────────────────────────────────
Write-Host "[1/3] Checking Java 21..." -ForegroundColor Yellow

$javaInstallPaths = @(
    "C:\Program Files\Java\jdk-21.0.10",
    "C:\Program Files\Java\jdk-21",
    "C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot",
    "C:\Program Files\Microsoft\jdk-21.0*"
)

$JAVA_HOME = $null
foreach ($path in $javaInstallPaths) {
    $resolved = Resolve-Path $path -ErrorAction SilentlyContinue
    if ($resolved) {
        $JAVA_HOME = $resolved.Path
        break
    }
}

if (-not $JAVA_HOME) {
    # Try to find any JDK 21 under Program Files
    $found = Get-ChildItem "C:\Program Files" -ErrorAction SilentlyContinue |
             Where-Object { $_.Name -match "jdk.*21" } |
             Select-Object -First 1
    if ($found) { $JAVA_HOME = $found.FullName }
}

if (-not $JAVA_HOME) {
    Write-Host ""
    Write-Host "  [ERROR] Java 21 JDK not found." -ForegroundColor Red
    Write-Host "  Please install Java 21 from one of these links:" -ForegroundColor Red
    Write-Host "    - https://www.oracle.com/java/technologies/downloads/#java21 (Oracle)" -ForegroundColor White
    Write-Host "    - https://adoptium.net/temurin/releases/?version=21 (Eclipse Temurin — free)" -ForegroundColor White
    Write-Host ""
    Write-Host "  After installing, re-run this script." -ForegroundColor Yellow
    exit 1
}

$env:JAVA_HOME = $JAVA_HOME
$env:Path = "$JAVA_HOME\bin;$env:Path"
Write-Host "  Found Java at: $JAVA_HOME" -ForegroundColor Green
& java -version 2>&1 | ForEach-Object { Write-Host "  $_" }

# ─── Step 2: Set up Maven ────────────────────────────────────
Write-Host ""
Write-Host "[2/3] Setting up Maven..." -ForegroundColor Yellow

$mavenPath = "C:\maven\apache-maven-3.9.6"

if (-not (Test-Path "$mavenPath\bin\mvn.cmd")) {
    Write-Host "  Maven not found at $mavenPath. Downloading Maven 3.9.6..."
    New-Item -ItemType Directory -Path "C:\maven" -Force | Out-Null
    $zipPath = "C:\maven\maven396.zip"
    Invoke-WebRequest -Uri "https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip" `
                      -OutFile $zipPath -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath "C:\maven\" -Force
    Remove-Item $zipPath -Force
    Write-Host "  Maven installed at $mavenPath" -ForegroundColor Green
} else {
    Write-Host "  Found Maven at: $mavenPath" -ForegroundColor Green
}

$env:Path = "$mavenPath\bin;$env:Path"
& mvn -version 2>&1 | Select-Object -First 1 | ForEach-Object { Write-Host "  $_" }

# ─── Step 3: Run the Application ─────────────────────────────
Write-Host ""
Write-Host "[3/3] Starting Library Management System..." -ForegroundColor Yellow
Write-Host ""

# Kill any existing process on port 8080
$existing = Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue
if ($existing) {
    $existing | Select-Object -ExpandProperty OwningProcess | Sort-Object -Unique |
    ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }
    Write-Host "  Cleared existing process on port 8080." -ForegroundColor DarkGray
}

Write-Host "  Access the API at: http://localhost:8080" -ForegroundColor Cyan
Write-Host "  H2 Database Console: http://localhost:8080/h2-console" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Press Ctrl+C to stop the server." -ForegroundColor DarkGray
Write-Host ""

mvn spring-boot:run

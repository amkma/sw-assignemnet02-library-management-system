# Library Management System - Startup Script
# Run this from the 'library' folder

Write-Host "Stopping any process on port 8080..." -ForegroundColor Yellow
Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty OwningProcess |
    Sort-Object -Unique |
    ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue; Write-Host "  Killed PID $_" }

Start-Sleep -Seconds 1

$env:JAVA_HOME = "C:\Program Files\Java\jdk-21.0.10"
$env:Path = "$env:JAVA_HOME\bin;C:\maven\apache-maven-3.9.6\bin;$env:Path"

Write-Host "Starting Library Management System..." -ForegroundColor Green
mvn spring-boot:run

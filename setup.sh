#!/bin/bash
# =============================================================
# Library Management System — Linux/macOS Setup Script
# =============================================================
# Make executable and run:
#   chmod +x setup.sh
#   ./setup.sh
# =============================================================

set -e

echo ""
echo "========================================="
echo "  Library Management System — Setup"
echo "========================================="
echo ""

# ─── Step 1: Check Java 21 ───────────────────────────────────
echo "[1/3] Checking Java 21..."

if command -v java &> /dev/null; then
    JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
    if [[ "$JAVA_VER" -ge 21 ]]; then
        echo "  Found Java: $(java -version 2>&1 | head -1)"
    else
        echo "  ERROR: Java version $JAVA_VER found, but Java 21+ is required."
        echo "  Install Java 21 using one of:"
        echo "    Ubuntu/Debian: sudo apt install openjdk-21-jdk"
        echo "    macOS (Homebrew): brew install openjdk@21"
        echo "    Or download from: https://adoptium.net/temurin/releases/?version=21"
        exit 1
    fi
else
    echo "  ERROR: Java not found."
    echo "  Install Java 21 using one of:"
    echo "    Ubuntu/Debian: sudo apt install openjdk-21-jdk"
    echo "    macOS (Homebrew): brew install openjdk@21"
    echo "    Or download from: https://adoptium.net/temurin/releases/?version=21"
    exit 1
fi

# ─── Step 2: Check Maven ─────────────────────────────────────
echo ""
echo "[2/3] Checking Maven..."

if command -v mvn &> /dev/null; then
    echo "  Found: $(mvn -version 2>&1 | head -1)"
else
    echo "  Maven not found. Using Maven Wrapper (./mvnw)..."
    if [[ -f "./mvnw" ]]; then
        chmod +x ./mvnw
        # Alias mvn to mvnw for the rest of the script
        alias mvn="./mvnw"
        echo "  Using ./mvnw"
    else
        echo "  ERROR: Neither mvn nor ./mvnw found."
        echo "  Install Maven:"
        echo "    Ubuntu/Debian: sudo apt install maven"
        echo "    macOS (Homebrew): brew install maven"
        exit 1
    fi
fi

# ─── Step 3: Run the Application ─────────────────────────────
echo ""
echo "[3/3] Starting Library Management System..."
echo ""

# Kill any existing process on port 8080
if lsof -Pi :8080 -sTCP:LISTEN -t &> /dev/null; then
    echo "  Clearing existing process on port 8080..."
    kill -9 $(lsof -Pi :8080 -sTCP:LISTEN -t) 2>/dev/null || true
fi

echo "  Access the API at:     http://localhost:8080"
echo "  H2 Database Console:   http://localhost:8080/h2-console"
echo ""
echo "  Press Ctrl+C to stop the server."
echo ""

mvn spring-boot:run

#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF)
# Maven Wrapper startup script (Unix)
# ----------------------------------------------------------------------------

set -e

if [ -n "$JAVA_HOME" ]; then
  JAVACMD="$JAVA_HOME/bin/java"
else
  JAVACMD="$(command -v java || true)"
fi

if [ -z "$JAVACMD" ] || [ ! -x "$JAVACMD" ]; then
  echo "Error: Java not found. Set JAVA_HOME or add java to PATH." >&2
  exit 1
fi

MAVEN_PROJECTBASEDIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"
MAVEN_WRAPPER_DIR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper"
MAVEN_WRAPPER_JAR="$MAVEN_WRAPPER_DIR/maven-wrapper.jar"
MAVEN_WRAPPER_PROPERTIES="$MAVEN_WRAPPER_DIR/maven-wrapper.properties"

if [ ! -f "$MAVEN_WRAPPER_PROPERTIES" ]; then
  echo "Error: Missing $MAVEN_WRAPPER_PROPERTIES" >&2
  exit 1
fi

DOWNLOAD_URL="$(sed -n 's/^distributionUrl=//p' "$MAVEN_WRAPPER_PROPERTIES" | tail -n 1 | tr -d '\r')"
WRAPPER_URL="$(sed -n 's/^wrapperUrl=//p' "$MAVEN_WRAPPER_PROPERTIES" | tail -n 1 | tr -d '\r')"

if [ -z "$DOWNLOAD_URL" ]; then
  DOWNLOAD_URL="https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip"
fi

if [ -z "$WRAPPER_URL" ]; then
  WRAPPER_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"
fi

if [ ! -f "$MAVEN_WRAPPER_JAR" ]; then
  mkdir -p "$MAVEN_WRAPPER_DIR"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$WRAPPER_URL" -o "$MAVEN_WRAPPER_JAR"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$MAVEN_WRAPPER_JAR" "$WRAPPER_URL"
  else
    echo "Error: curl or wget is required to download Maven Wrapper jar." >&2
    exit 1
  fi
fi

exec "$JAVACMD" \
  -classpath "$MAVEN_WRAPPER_JAR" \
  "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" \
  org.apache.maven.wrapper.MavenWrapperMain \
  "$@"
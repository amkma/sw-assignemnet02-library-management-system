#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF)
# Maven Start Up Batch script
# ----------------------------------------------------------------------------

if [ -z "$JAVA_HOME" ] ; then
  JAVACMD=`which java`
else
  JAVACMD="$JAVA_HOME/bin/java"
fi

MAVEN_PROJECTBASEDIR="${BASH_SOURCE%/*}"
MAVEN_WRAPPER_JAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"
MAVEN_WRAPPER_PROPERTIES="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.properties"

DOWNLOAD_URL=$(grep distributionUrl "$MAVEN_WRAPPER_PROPERTIES" | cut -d= -f2)

# If wrapper jar not present, download it
if [ ! -f "$MAVEN_WRAPPER_JAR" ]; then
  WRAPPER_URL=$(grep wrapperUrl "$MAVEN_WRAPPER_PROPERTIES" | cut -d= -f2)
  if command -v curl > /dev/null; then
    curl -o "$MAVEN_WRAPPER_JAR" "$WRAPPER_URL" -s
  elif command -v wget > /dev/null; then
    wget -q -O "$MAVEN_WRAPPER_JAR" "$WRAPPER_URL"
  fi
fi

exec "$JAVACMD" -jar "$MAVEN_WRAPPER_JAR" "$DOWNLOAD_URL" "$@"

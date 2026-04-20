@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF)
@REM Maven Start Up Batch script
@REM
@REM Required ENV vars:
@REM JAVA_HOME - location of a JDK home dir
@REM ----------------------------------------------------------------------------

@SETLOCAL

@IF "%__MVNW_ARG0_NAME__%"=="" (
  SET "BASE_DIR=%~dp0"
) ELSE (
  SET "BASE_DIR=%__MVNW_ARG0_NAME__%"
)

@IF "%BASE_DIR:~-1%"=="\" SET "BASE_DIR=%BASE_DIR:~0,-1%"

@SET "MAVEN_PROJECTBASEDIR=%BASE_DIR%"
@SET "MAVEN_WRAPPER_JAR=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
@SET "MAVEN_WRAPPER_PROPERTIES=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties"

@IF NOT EXIST "%MAVEN_WRAPPER_PROPERTIES%" (
  ECHO Could not find %MAVEN_WRAPPER_PROPERTIES%
  EXIT /B 1
)

@FOR /F "usebackq tokens=1,* delims==" %%a IN ("%MAVEN_WRAPPER_PROPERTIES%") DO (
  @IF /I "%%a"=="distributionUrl" SET "DOWNLOAD_URL=%%b"
  @IF /I "%%a"=="wrapperUrl" SET "WRAPPER_URL=%%b"
)

@IF "%DOWNLOAD_URL%"=="" SET "DOWNLOAD_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip"
@IF "%WRAPPER_URL%"=="" SET "WRAPPER_URL=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar"

@IF NOT EXIST "%MAVEN_WRAPPER_JAR%" (
  @IF NOT "%MVNW_VERBOSE%"=="" ECHO Downloading Maven Wrapper from: %WRAPPER_URL%
  @powershell -NoProfile -Command ^
    "$ErrorActionPreference='Stop';" ^
    "$webclient = New-Object System.Net.WebClient;" ^
    "if (-not ([string]::IsNullOrEmpty('%MVNW_USERNAME%') -and [string]::IsNullOrEmpty('%MVNW_PASSWORD%'))) { $webclient.Credentials = New-Object System.Net.NetworkCredential('%MVNW_USERNAME%','%MVNW_PASSWORD%'); }" ^
    "$webclient.DownloadFile('%WRAPPER_URL%','%MAVEN_WRAPPER_JAR%');"
)

@IF NOT EXIST "%MAVEN_WRAPPER_JAR%" (
  ECHO Failed to download Maven Wrapper jar: %MAVEN_WRAPPER_JAR%
  EXIT /B 1
)

@IF "%JAVA_HOME%"=="" (
  SET "JAVACMD=java"
) ELSE (
  SET "JAVACMD=%JAVA_HOME%\bin\java"
)

@"%JAVACMD%" -classpath "%MAVEN_WRAPPER_JAR%" "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" org.apache.maven.wrapper.MavenWrapperMain %*
@EXIT /B %ERRORLEVEL%
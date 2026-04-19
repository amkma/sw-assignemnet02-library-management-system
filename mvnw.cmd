@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF)
@REM Maven Start Up Batch script
@REM
@REM Required ENV vars:
@REM JAVA_HOME - location of a JDK home dir
@REM ----------------------------------------------------------------------------

@IF "%__MVNW_ARG0_NAME__%"=="" (SET "BASE_DIR=%~dp0") ELSE (SET "BASE_DIR=%__MVNW_ARG0_NAME__%")

@SET MAVEN_PROJECTBASEDIR=%BASE_DIR%
@SET MAVEN_WRAPPER_JAR=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar
@SET MAVEN_WRAPPER_PROPERTIES=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties

@FOR /F "usebackq tokens=1,* delims==" %%a IN ("%MAVEN_WRAPPER_PROPERTIES%") DO (
    @IF "%%a"=="distributionUrl" SET DOWNLOAD_URL=%%b
    @IF "%%a"=="wrapperUrl" SET WRAPPER_URL=%%b
)

@IF NOT EXIST "%MAVEN_WRAPPER_JAR%" (
    @IF NOT "%MVNW_VERBOSE%"=="" ECHO Downloading Maven Wrapper from: %WRAPPER_URL%
    @powershell -Command "&{"^
        "$webclient = new-object System.Net.WebClient;"^
        "if (-not ([string]::IsNullOrEmpty('%MVNW_USERNAME%') -and [string]::IsNullOrEmpty('%MVNW_PASSWORD%'))) {"^
        "$webclient.Credentials = new-object System.Net.NetworkCredential('%MVNW_USERNAME%', '%MVNW_PASSWORD%');"^
        "}"^
        "$webclient.DownloadFile('%WRAPPER_URL%', '%MAVEN_WRAPPER_JAR%')"^
        "}"
)

@IF "%JAVA_HOME%"=="" (
    SET JAVACMD=java
) ELSE (
    SET JAVACMD=%JAVA_HOME%\bin\java
)

@"%JAVACMD%" ^
  -jar "%MAVEN_WRAPPER_JAR%" ^
  "%DOWNLOAD_URL%" ^
  %*

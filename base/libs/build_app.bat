@ECHO OFF
REM ##### If you dont want to display running commands than just change ECHO ON to ECHO OFF

SET APP_DIR=c:\app
SET BUNDLE_DIR=C:\tmp\bundle-dir

REM ### Just to make sure that meteor is in PATH
setx /M Path "%LocalAppData%\\.meteor;%Path%"

mkdir C:\tmp\bundle-dir

if "%errorlevel%"=="1" (
	ECHO "Failed to create required directories."
	GOTO END
)

CD "%APP_DIR%"
ECHO "=> Executing NPM install --production"
meteor npm install --production
ECHO "=> Executing meteor build"
meteor build "%BUNDLE_DIR%" --server-only --architecture os.windows.x86_64

if "%errorlevel%"=="1" (
	GOTO END
)

ECHO "=> Printing Meteor Node information..."
ECHO "  => platform"
meteor node -p process.platform
ECHO "  => arch"
meteor node -p process.arch
ECHO "  => versions"
meteor node -p process.versions

ECHO "=> Printing System Node information..."
ECHO "  => platform"
node -p process.platform
ECHO "  => arch"
node -p process.arch
ECHO "  => versions"
node -p process.versions

ECHO "=> Executing NPM install within Bundle"
cd "%BUNDLE_DIR%"/bundle/programs/server/
npm i

mkdir c:\built_app

ECHO "=> Moving bundle"
MOVE "%BUNDLE_DIR%"/bundle c:/built_app

if "%errorlevel%"=="1" (
	GOTO END
)

ECHO "=> Cleaning up"
# cleanup
ECHO " => BUNDLE_DIR"
rmdir /S /Q %BUNDLE_DIR%
ECHO " => Deleting meteor => %LocalAppData%\\.meteor"
rmdir /S /Q "%LocalAppData%\\.meteor"

:END
REM ECHO "Completed with code %errorlevel%"
if "%errorlevel%"=="1" (
	  echo "Failed"
	  EXIT /B "%errorlevel%"
)
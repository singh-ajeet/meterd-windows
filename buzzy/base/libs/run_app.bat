@ECHO OFF

ECHO "========================================>"

cd "%BUNDLE_DIR%"/bundle/programs/server/

if "%errorlevel%"=="1" (
	GOTO END
)

ECHO "==== Processing =====>"

:END
REM ECHO "Completed with code %errorlevel%"
if "%errorlevel%"=="1" (
	   echo "Failed"
	 REM  EXIT /B "%errorlevel%"
)

ECHO "This line should not process."
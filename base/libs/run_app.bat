@ECHO OFF

if "%1%"=="-d" (
	GOTO :BUNDLE
)

ECHO "=> You don't have an meteor app to run in this image."
GOTO :END

:BUNDLE
  if "%2%" == "/built_app" (
     ECHO "=> Using bundle from c:\built_app"
     cd c:\built_app
	 GOTO :START_APP
  )
  GOTO :END

:START_APP
  SET PORT=80

  ECHO "=> Starting meteor app on port:$PORT"
  node "%METEORD_NODE_OPTIONS%" main.js
  GOTO :END
  
:END
REM ECHO "Completed with code %errorlevel%"
  if "%errorlevel%"=="1" (
	  echo "Failed"
  )
  EXIT /B "%errorlevel%"
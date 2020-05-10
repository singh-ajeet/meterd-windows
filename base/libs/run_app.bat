@ECHO OFF

ECHO "=> Using bundle from c:\built_app"
cd c:\built_app

SET PORT=80
ECHO "=> Starting meteor app on port:%PORT%"
node "%METEORD_NODE_OPTIONS%" main.js	 

EXIT /B "%errorlevel%"

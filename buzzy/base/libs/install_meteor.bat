@ECHO OFF

mkdir c:\tmp

ECHO "=> Downling meteor tar.gz  ..."
powershell -Command Invoke-WebRequest http://static-meteor.netdna-ssl.com/packages-bootstrap/1.10.2/meteor-bootstrap-os.windows.x86_64.tar.gz -OutFile c:/tmp/meteor.tar.gz

if "%errorlevel%"=="1" (
	ECHO "Failed to download meteor tar.gz bundle."
	GOTO :END
)

ECHO "=> Uncompressig meteor tar.gz  ..."
powershell -Command 7z x c:/tmp/meteor.tar.gz -o"c:/tmp/" 
powershell -Command 7z x c:/tmp/meteor.tar -o"%LocalAppData%" 

if "%errorlevel%"=="1" (
    ECHO "Failed to un compress meteor tar.gz bundle."
	GOTO :END
)

ECHO "=> Cleaning temp directries ..."
powershell -Command Remove-Item c:/tmp/*.*  -Force

setx /M Path "%LocalAppData%\\.meteor;%Path%"

:END
REM ECHO "Completed with code %errorlevel%"
if "%errorlevel%"=="1" (
	  echo "Failed"
	  EXIT /B "%errorlevel%"
)
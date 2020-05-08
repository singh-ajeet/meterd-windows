@ECHO OFF

IF "%1"=="-d" (
   IF "%2" == "/bundle" (
     GOTO bundle
   )
) 

IF  "%BUNDLE_URL%" NEQ  "" (
	 GOTO bundle2
)


:bundle
ECHO ECHO "=============>"
goto end

:bundle2
ECHO ECHO "<============="
goto end

:end

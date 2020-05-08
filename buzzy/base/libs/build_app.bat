@ECHO OFF

SET COPIED_APP_PATH=C:/copied-app
SET BUNDLE_DIR=C:/tmp/bundle-dir

ECHO "=>########## Assuming that your app already in C:/app directory"
ECHO "=> Copying the app to %COPIED_APP_PATH%"
COPY "C:\app" "%COPIED_APP_PATH%"
CD "%COPIED_APP_PATH%"

ECHO "=> Executing NPM install --production"
meteor npm install --production

mkdir c:\buzzybuildwindows

ECHO "=> Executing Meteor Build..."
meteor build ../buzzybuildwindows --server-only --allow-superuser --directory "%BUNDLE_DIR%" --server=http://localhost:3000 
REM #### meteor build ../buzzybuildwindows --server-only --architecture os.windows.x86_64

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

MKDIR c:/built_app

ECHO "=> Moving bundle"
MOVE "%BUNDLE_DIR%"/bundle c:/built_app

ECHO "=> Cleaning up"
# cleanup
ECHO " => Deleting %COPIED_APP_PATH%"
rmdir /S /Q $COPIED_APP_PATH
ECHO " => BUNDLE_DIR"
rmdir /S /Q %BUNDLE_DIR%
ECHO " => Deleting meteor => %LocalAppData%"
rmdir /S /Q "%LocalAppData%"

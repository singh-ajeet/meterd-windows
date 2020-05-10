FROM buzzy:base-ltsc2019

# copy the newer app source from the local app directory to container
ONBUILD COPY ./ c:/app

# Set the working directory
ONBUILD WORKDIR "C:/app"

## Chocolatery is installing older version of meteor, so we are manually installing it
ONBUILD ADD http://static-meteor.netdna-ssl.com/packages-bootstrap/1.10.2/meteor-bootstrap-os.windows.x86_64.tar.gz "c:/tmp/meteor.tar.gz"
ONBUILD RUN powershell -Command \
           7z x c:/tmp/meteor.tar.gz -o"c:/tmp/" ; \
           7z x c:/tmp/meteor.tar -o"%LocalAppData%" 

## Cleanup
ONBUILD RUN powershell -command \ 
        Remove-Item c:/tmp/*.*  -Force

ONBUILD RUN setx /M Path "%LocalAppData%\\.meteor;%Path%"

ONBUILD RUN "cmd /c c:/libs/build_app.bat"
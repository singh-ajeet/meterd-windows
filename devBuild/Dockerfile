FROM buzzy:base-ltsc2019

ARG NODE_VERSION=12.16.1
ENV node_version=$NODE_VERSION

## Chocolatery is installing older version of meteor, so we are manually installing it
ADD http://static-meteor.netdna-ssl.com/packages-bootstrap/1.10.2/meteor-bootstrap-os.windows.x86_64.tar.gz "c:/tmp/meteor.tar.gz"
RUN powershell -Command \
        7z x c:/tmp/meteor.tar.gz -o"c:/tmp/" ; \
        7z x c:/tmp/meteor.tar -o"%LocalAppData%" 

## Cleanup
RUN powershell -command \ 
        Remove-Item c:/tmp/*.*  -Force

RUN setx /M Path "%LocalAppData%\\.meteor;%Path%"

ONBUILD COPY ./ c:/app
ONBUILD RUN "cmd /c c:/libs/build_app.bat"

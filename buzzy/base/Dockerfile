FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Metadata indicating an image maintainer.
LABEL maintainer="ajeetsinghtomer@gmail.com"

ARG NODE_VERSION
ENV NODE_VERSION ${NODE_VERSION:-12.16.1}
ENV PHANTOMJS_VERSION=1.9.8

ONBUILD ENV NODE_VERSION ${NODE_VERSION:-12.16.1}

### We will use chocolatey to install packages
ENV chocolateyUseWindowsCompression false

RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN powershell -Command \
    choco install 7zip -y --force ; \
    choco install nodejs.install -y --force --version="%NODE_VERSION%" ; \
    choco install phantomjs -y --force --version="%PHANTOMJS_VERSION%" ; \
    New-Item -ItemType "directory" -Path "c:\tmp"

## Chocolatery is installing older version of meteor, so we are manually installing it
ADD http://static-meteor.netdna-ssl.com/packages-bootstrap/1.10.2/meteor-bootstrap-os.windows.x86_64.tar.gz "c:/tmp/meteor.tar.gz"
RUN powershell -Command \
    7z x c:/tmp/meteor.tar.gz -o"c:/tmp/" ; \
    7z x c:/tmp/meteor.tar -o"%LocalAppData%" 

## Cleanup
RUN powershell -command \ 
    Remove-Item c:/tmp/*.* -Force 

RUN setx /M Path "%LocalAppData%\\.meteor;%Path%"

## These scripts are for testing purpose only
COPY tests c:/tests

#RUN powershell -Command "choco install meteor -y --force"

ENV NPM_CONFIG_LOGLEVEL info
### to compile native Node modules, we need windows build tools

#RUN npm install -g windows-build-tools

CMD npm && cmd
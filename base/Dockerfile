FROM mcr.microsoft.com/windows/servercore:ltsc2019	

# Metadata indicating an image maintainer.
LABEL maintainer="ajeetsinghtomer@gmail.com"

ARG NODE_VERSION=12.16.1
ENV node_version=$NODE_VERSION

ARG PHANTOMJS_VERSION=1.9.8
ENV phantomjs_version=$PHANTOMJS_VERSION

### We will use chocolatey to install packages
ENV chocolateyUseWindowsCompression false

RUN ECHO "=> Installing chocolatey ..."
RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN ECHO "=> Installing Nodejs and phantomjs ..."
RUN powershell -Command \
    choco install 7zip -y --force ; \
    choco install nodejs.install -y --force --version="%NODE_VERSION%" ; \
    choco install phantomjs -y --force --version="%PHANTOMJS_VERSION%" ; \
    New-Item -ItemType "directory" -Path "c:\tmp" ; \
    New-Item -ItemType "directory" -Path "c:/bundle"
   

## These scripts are for testing purpose only
COPY tests c:/tests

COPY libs c:/libs

##user ContainerAdministrator
##RUN whoami

RUN echo "=> Installing meteor ..."
RUN powershell -Command "choco install meteor -y --force"

##RUN echo "=> Copying 7zip to meteor installation ..."
##COPY 7z.exe "%LocalAppData%\.meteor\packages\meteor-tool\1.10.2\mt-os.windows.x86_64\dev_bundle\bin"

ENV NPM_CONFIG_LOGLEVEL info

### to compile native Node modules, we need windows build tools
RUN powershell -Command \
    npm install --global windows-build-tools@4.0.0

EXPOSE 80

CMD C:\libs\run_app.bat && cmd
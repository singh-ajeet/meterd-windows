FROM mcr.microsoft.com/windows/servercore:ltsc2019	

# Metadata indicating an image maintainer.
LABEL maintainer="ajeetsinghtomer@gmail.com"

ARG NODE_VERSION=12.16.1
ENV node_version=$NODE_VERSION

ARG PHANTOMJS_VERSION=1.9.8
ENV phantomjs_version=$PHANTOMJS_VERSION

ARG PORT=3000
ENV port=$PORT

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
    New-Item -ItemType "directory" -Path "c:\tmp\bundleDir" ; \
    New-Item -ItemType "directory" -Path "c:\builtApp"
   
ENV NPM_CONFIG_LOGLEVEL info

COPY libs c:/libs
ONBUILD COPY bundle c:/tmp

ONBUILD RUN ECHO "=> Extracting and deploying application ..."
ONBUILD RUN powershell -Command \
            7z x c:/tmp/*.tar.gz -o"c:\tmp" ; \
            7z x c:/tmp/*.tar -o"c:\tmp\bundleDir"  ; \
            Set-Location -Path "C:\tmp\bundleDir\bundle\programs\server" ; \
            npm install --unsafe-perm ; \
            Set-Location -Path "c:\builtApp" ; \
            Copy-Item -Path "C:\tmp\bundleDir\bundle\*" -Destination "C:\builtApp" -Recurse ; \
            Remove-Item -LiteralPath "c:\tmp" -Force -Recurse

ONBUILD RUN ECHO "=> Printing System Node information"
ONBUILD RUN powershell -command \
        ECHO "  => platform"   ; \
        node -p process.platform   ; \
        ECHO "  => arch"   ; \
        node -p process.arch   ; \
        ECHO "  => versions"   ; \
        node -p process.versions 

ONBUILD EXPOSE 3000

ONBUILD WORKDIR c:/builtApp

CMD "c:\libs\app_run.bat" && cmd
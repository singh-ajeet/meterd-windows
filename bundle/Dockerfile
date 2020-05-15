FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Metadata indicating an image maintainer.
LABEL maintainer="ajeetsinghtomer@gmail.com"

#### S3 credentials to download application bundle ##
ARG s3key=key
ENV AWS_ACCESS_KEY_ID=$s3key

ARG s3scret=secret
ENV AWS_SECRET_ACCESS_KEY=$s3scret

ARG region=US-EAST-1
ENV AWS_DEFAULT_REGION=$region

ARG s3path=path
ENV S3_PATH=$s3path
#####################################################
ARG NODE_VERSION=8.15.1
ENV node_version=$NODE_VERSION

ARG PHANTOMJS_VERSION=1.9.8
ENV phantomjs_version=$PHANTOMJS_VERSION

ARG PORT=3000
ENV port=$PORT

### We will use chocolatey to install packages
ENV chocolateyUseWindowsCompression false

RUN ECHO "=> %AWS_ACCESS_KEY_ID%"

RUN ECHO "=> Installing chocolatey ..."
RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN ECHO "=> Installing Nodejs and phantomjs ..."
RUN powershell -Command \
    choco install 7zip -y --force ; \
    choco install nodejs.install -y --force --version="%NODE_VERSION%" ; \
    choco install phantomjs -y --force --version="%PHANTOMJS_VERSION%" ; \
    choco install awscli -y --force ; \
    New-Item -ItemType "directory" -Path "c:\tmp\bundleDir" ; \
    New-Item -ItemType "directory" -Path "c:\builtApp"

ENV NPM_CONFIG_LOGLEVEL info

RUN npm install --global --production --add-python-to-path windows-build-tools --vs2015

COPY libs c:/libs
RUN aws s3 cp "%S3_PATH%" c:/tmp

RUN ECHO "=> Extracting and deploying application ..."
RUN powershell -Command \
            7z x c:/tmp/*.tar.gz -o"c:\tmp" ; \
            7z x c:/tmp/*.tar -o"c:\tmp\bundleDir"  ; \
            Set-Location -Path "C:\tmp\bundleDir\bundle\programs\server" ; \
            npm install node-gyp ; \
            npm install bcrypt ; \
            npm install --production ; \
            Set-Location -Path "c:\builtApp" ; \
            Copy-Item -Path "C:\tmp\bundleDir\bundle\*" -Destination "C:\builtApp" -Recurse ; \
            Remove-Item -LiteralPath "c:\tmp" -Force -Recurse

RUN ECHO "=> Printing System Node information"
RUN powershell -command \
        ECHO "  => platform"   ; \
        node -p process.platform   ; \
        ECHO "  => arch"   ; \
        node -p process.arch   ; \
        ECHO "  => versions"   ; \
        node -p process.versions

EXPOSE 3000

WORKDIR c:/builtApp

CMD "c:\libs\app_run.bat" && cmd

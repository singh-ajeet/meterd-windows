FROM mcr.microsoft.com/windows/servercore:ltsc2019 as builder

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
    New-Item -ItemType "directory" -Path "c:\app"

RUN npm install --global --production --add-python-to-path windows-build-tools --vs2015

RUN aws s3 cp "%S3_PATH%" c:/tmp

RUN ECHO "=> Extracting and deploying application ..."
RUN powershell -Command \
            7z x c:/tmp/*.tar.gz -o"c:\tmp" ; \
            7z x c:/tmp/*.tar -o"c:\tmp\bundleDir"  ; \
            Set-Location -Path "C:\tmp\bundleDir\bundle\programs\server" ; \
            npm install --production ; \
            Set-Location -Path "c:\app" ; \
            Copy-Item -Path "C:\tmp\bundleDir\bundle\*" -Destination "C:\app" -Recurse ; \
            Remove-Item -LiteralPath "c:\tmp" -Force -Recurse

########## Now make the target image ########################
FROM mcr.microsoft.com/windows/nanoserver:1809
COPY --from=builder ["C:/Program Files/nodejs", "C:/Program Files/nodejs"]
COPY --from=builder ["C:/app", "C:/app"]
COPY bundle/libs c:/libs

# Add the command and bin directories to the environment path
ENV PATH "C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\Program Files\\nodejs;C:\\Users\\ContainerAdministrator\\AppData\\Roaming\\npm"

WORKDIR "C:/app"

ENV PORT 3000
EXPOSE ${PORT}
CMD "c:\libs\app_run.bat" && cmd
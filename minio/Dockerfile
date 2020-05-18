FROM mcr.microsoft.com/windows/servercore:ltsc2019 as builder
LABEL maintainer="ajeetsinghtomer@gmail.com"
# Uses dism.exe to install the IIS role.
# RUN dism.exe /online /enable-feature /all /featurename:iis-webserver /NoRestart

RUN "powershell.exe  -Command mkdir c:/minio/data/" 
RUN "powershell.exe  -Command Invoke-WebRequest "https://dl.min.io/server/minio/release/windows-amd64/minio.exe" -OutFile c:/minio/minio.exe"


########## Now make the target image ########################
FROM mcr.microsoft.com/windows/nanoserver:1809

COPY --from=builder ["c:/minio/minio.exe", "c:/minio/minio.exe"]
COPY minio-server.bat c:/minio/minio-server.bat

EXPOSE 9000
# CMD ["cmd", "c:/minio/minio-server.bat"]
CMD c:/minio/minio-server.bat && cmd
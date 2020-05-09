@ECHO OFF

## Chocolatery is installing older version of meteor, so we are manually installing it
wget http://static-meteor.netdna-ssl.com/packages-bootstrap/1.10.2/meteor-bootstrap-os.windows.x86_64.tar.gz "c:/tmp/meteor.tar.gz"
RUN powershell -Command \
        7z x c:/tmp/meteor.tar.gz -o"c:/tmp/" ; \
        7z x c:/tmp/meteor.tar -o"%LocalAppData%" 
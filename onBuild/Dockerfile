FROM buzzy:base-ltsc2019

ARG APP_DIR=c:\app

ARG NODE_FLAGS="--max-old-space-size=2096 --optimize_for_size --gc-interval=100"
ENV TOOL_NODE_FLAGS=$NODE_FLAGS

# copy the newer app source from the local app directory to container
ONBUILD COPY ./ c:/app

# Set the working directory
ONBUILD WORKDIR "C:/app"

## Chocolatery is installing older version of meteor, so we are manually installing it
ONBUILD ADD http://static-meteor.netdna-ssl.com/packages-bootstrap/1.10.2/meteor-bootstrap-os.windows.x86_64.tar.gz "c:/tmp/meteor.tar.gz"
ONBUILD RUN powershell -Command \
           7z x c:/tmp/meteor.tar.gz -o"c:/tmp/" ; \
           7z x c:/tmp/meteor.tar -o"%LocalAppData%" ; \
		   New-Item -ItemType "directory" -Path "C:\tmp\bundle-dir"

## Cleanup
ONBUILD RUN powershell -command \ 
        Remove-Item c:/tmp/*.*  -Force

ONBUILD RUN setx /M Path "%LocalAppData%\\.meteor;%Path%"

### Running meteor npm install
ONBUILD RUN powershell -command \ 
        ECHO "=> Running meteor npm install --production ..."  ; \
        meteor npm install --production

### Build application
ONBUILD RUN powershell -command \ 
        ECHO "=> Running meteor build ..."  ; \
        meteor build --server-only --allow-superuser --directory C:\tmp\bundle-dir --server=http://localhost:3000  --architecture os.windows.x86_64
##	meteor build "C:\tmp\bundle-dir" --server-only --architecture os.windows.x86_64

### Displaying node info		
ONBUILD RUN powershell -command \ 		
	ECHO "=> Printing Meteor Node information..."  ; \
        ECHO "  => platform"  ; \
        meteor node -p process.platform  ; \
        ECHO "  => arch"  ; \
        meteor node -p process.arch  ; \
        ECHO "  => versions"  ; \
        meteor node -p process.versions  ; \
	ECHO "=> Printing System Node information..."   ; \
        ECHO "  => platform"   ; \
        node -p process.platform   ; \
        ECHO "  => arch"   ; \
        node -p process.arch   ; \
        ECHO "  => versions"   ; \
        node -p process.versions 
		
ONBUILD RUN powershell -command \ 
        ECHO "=> Executing NPM install within Bundle"    ; \
        cd "C:\tmp\bundle-dir\bundle\programs\server\"   ; \
        npm i   ; \
        mkdir c:\built_app   ; \
        ECHO "=> Moving bundle"   ; \
        MOVE "C:\tmp\bundle-dir\bundle c:\built_app 

ONBUILD RUN powershell -command \ 
        ECHO "=> Cleaning up" ; \		
	ECHO " => C:\tmp\bundle-dir"  ; \	
        rmdir /S /Q C:\tmp\bundle-dir  ; \	
        ECHO " => Deleting meteor => %LocalAppData%\\.meteor"  ; \	
        rmdir /S /Q "%LocalAppData%\\.meteor"
		
#### ONBUILD RUN "cmd /c c:/libs/build_app.bat"
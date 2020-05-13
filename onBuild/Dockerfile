FROM buzzy:base-ltsc2019

ARG APP_DIR=c:/app

ARG NODE_FLAGS="--max-old-space-size=2096 --optimize_for_size --gc-interval=100"
ENV TOOL_NODE_FLAGS=$NODE_FLAGS

# copy the newer app source from the local app directory to container
ONBUILD COPY . c:/app

ONBUILD RUN powershell -command \ 
        New-Item -ItemType "directory" -Path "C:\tmp\bundle-dir"

# Set the working directory
ONBUILD WORKDIR "c:/app"

### Running meteor npm install
ONBUILD RUN ECHO "=> Running meteor npm install --production ..."
ONBUILD RUN meteor npm install --production

### Build application
ONBUILD RUN ECHO "=> Running meteor build ..."
ONBUILD RUN meteor build c:/tmp/bundle-dir --server-only --architecture os.windows.x86_64
###ONBUILD RUN meteor build --server-only --directory "c:\tmp\bundle-dir" --architecture os.windows.x86_64

ONBUILD RUN  ECHO "=> Printing Meteor Node information..." 
ONBUILD RUN powershell -command \	
        ECHO "  => platform"  ; \
        meteor node -p process.platform  ; \
        ECHO "  => arch"  ; \
        meteor node -p process.arch  ; \
        ECHO "  => versions"  ; \
        meteor node -p process.versions

ONBUILD RUN ECHO "=> Printing System Node information"
ONBUILD RUN powershell -command \
        ECHO "  => platform"   ; \
        node -p process.platform   ; \
        ECHO "  => arch"   ; \
        node -p process.arch   ; \
        ECHO "  => versions"   ; \
        node -p process.versions 

##ONBUILD WORKDIR "C:/tmp/bundle-dir/bundle/programs/server/"

ONBUILD RUN powershell -command \
        cd "C:\tmp\bundle-dir\bundle\programs\server\" ; \
        npm i ; \
        mkdir c:\built_app ; \
        MOVE "C:\tmp\bundle-dir\bundle c:\built_app 

##ONBUILD RUN ECHO "=> Cleanup ..." 
##ONBUILD RUN rmdir /S /Q "C:\tmp\bundle-dir" ; \
##            rmdir /S /Q "%LocalAppData%\.meteor"

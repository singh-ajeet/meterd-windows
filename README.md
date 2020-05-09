# Commands to create docker images.

docker build  --file Dockerfile_choco -t buzzy:base-ltsc2019 .
docker run -it buzzy_choco:windows-server2019
docker run -it buzzy_choco:windows-server2019 cmd

== Base image ==
docker build -t buzzy:base-ltsc2019 .
 == or ==
docker build --build-arg NODE_VERSION=12.16.1 --build-arg PHANTOMJS_VERSION=1.9.8 -t buzzy:base-ltsc2019 .
 
== Build image == 
docker build -t buzzy:onBuild-ltsc2019 .
docker build --build-arg NODE_VERSION=12.15.0 -t buzzy:devBuild-ltsc2019 .

Create a new Dockerfile in root directory of your application with single "FROM  buzzy:onBuild-ltsc2019" and build docker image of with your application






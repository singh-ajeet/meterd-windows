# Commands to create docker images.

## Build docker images

###### Base image
```
docker build -t buzzy:base-ltsc2019 .
 == or ==
docker build --build-arg NODE_VERSION=12.16.1 --build-arg PHANTOMJS_VERSION=1.9.8 -t buzzy:base-ltsc2019 .
``` 
###### onBuild image 
```
docker build -t buzzy:onBuild-ltsc2019 .
docker build --build-arg NODE_VERSION=12.15.0 -t buzzy:devBuild-ltsc2019 .
```
Create a new Dockerfile in root directory of your application with single "FROM  buzzy:onBuild-ltsc2019" and build docker image of with your application

###### Example docker file
```
FROM  buzzy:onBuild-ltsc2019
```
###### Example command to create a docker image with application
```
docker build -t your_application:version-ltsc2019 .
```







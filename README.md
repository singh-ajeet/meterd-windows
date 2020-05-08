# Commands to create docker images.

docker build -t buzzy:base-ltsc2019 .
docker build -t buzzy:onBuild-ltsc2019 .

docker build --build-arg NODE_VERSION=12.16.1 --build-arg PHANTOMJS_VERSION=1.9.8 -t buzzy:base-ltsc2019 .



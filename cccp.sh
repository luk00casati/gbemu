#!/bin/sh
docker build -t cc/dev:1.0 .
docker run --name cc-container cc/dev:1.0
docker cp cc-container:/app/myapp ./build/myapp
docker cp cc-container:/app/mytest ./build/mytest
docker cp cc-container:/app/libemu.so ./build/libemu.so
docker stop cc-container
docker rm cc-container
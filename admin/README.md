Admin module for xm_exercise
==========================================

# Rebuild documentation:
```
swagger generate spec -o ../../doc/swagger.json
```
-----------------------
# build in docker

```
docker stop admin
docker rm admin
docker rmi admin:latest
docker build -f Dockerfile -t admin .
docker run -p 8400:8400 --name admin -d admin:latest
```

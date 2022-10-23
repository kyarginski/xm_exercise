Companies dictionary
==========================================

# Refresh documentation:
```
swagger generate spec -o ../../doc/swagger.json
```

-----------------------
# build in docker

```
docker stop companies
docker rm companies
docker rmi companies:latest
docker build -f Dockerfile -t companies .

docker run -p 8405:8405 --name companies -d companies:latest
```
----------------------
# Data migration 

For scripts see in .\migrations

Run
```
make migrate
```

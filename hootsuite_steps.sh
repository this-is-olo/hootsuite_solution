#!/bin/bash

#requires docker, awscli and wget installed

# 1. run mongodb container
sudo docker run --name mongodb -p 27017:27017 -v ~/docker-mongo:/shared mongo &;
# 2. download dataset from https://docs.mongodb.com/getting-started/shell/import-data/ and import to populate database
sudo rm -rf ~/docker-mongo/*;
sudo wget http://media.mongodb.org/zips.json -P ~/docker-mongo;
sudo docker exec -it mongodb mongoimport --db test --collection zips --drop --file shared/zips.json;
# 3. start fakes3 docker container
sudo docker run -p 4567:4567 --rm --name fakes3 verespej/fake-s3;
# 4. run backup script
bash backup_script.sh test ;


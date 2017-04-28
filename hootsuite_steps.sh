#!/bin/bash

#requires docker, awscli and wget installed

# 1. run mongodb container
sudo docker run --name mongodb -p 27017:27017 -v ~/docker-mongo:/shared mongo &;
# 2. download dataset from https://docs.mongodb.com/getting-started/shell/import-data/ and import to populate database
rm -f ~/docker-mongo;
sudo wget https://raw.githubusercontent.com/mongodb/docs-assets/primer-dataset/primer-dataset.json -P ~/docker-mongo;
sudo docker exec -it mongodb mongoimport --db test --collection restaurants --drop --file shared/primer-dataset.json;
# 3. start fakes3 docker container
sudo docker run --name fake-s3 -p 4569:4569 -d lphoward/fake-s3 &;
# 4. run backup script
bash backup_script.sh test ;


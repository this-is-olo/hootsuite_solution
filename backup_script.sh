#!/bin/bash

#requires following the steps for seting up docker containers and populating db and having awscli instaled

# dump mongodb in volume
sudo docker exec -it mongodb mongodump --db $1 -h localhost --port 27017 -o shared/mongo_bu;
# random credentials
export AWS_ACCESS_KEY_ID=1234
export AWS_SECRET_ACCESS_KEY=1234
# make new bucket
aws --endpoint-url='http://localhost:4567' s3 mb s3://fakes3 --region eu-central-1;
# copy database dump in bucket
aws --endpoint-url='http://localhost:4567' s3 cp ~/docker-mongo/mongo_bu s3://fakes3/mongo_bu --recursive;
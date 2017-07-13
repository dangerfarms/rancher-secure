#! /bin/bash

echo "Creating DB dump; better safe than sorry";
docker exec ranchersecure_db_1 mysqldump -u cattle -pcattle cattle > dump.sql

echo "Upgrading services"
docker-compose stop; 
docker-compose pull; 
docker-compose rm nginx; 
docker-compose up -d;

#! /bin/bash
docker-compose stop; 
docker-compose pull; 
docker-compose rm nginx; 
docker-compose up -d;

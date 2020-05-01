#!/bin/bash
docker build -t test:v1 .
docker run -dit -p 9000:9000 test:v1


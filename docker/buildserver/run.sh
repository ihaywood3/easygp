#!/bin/bash

sudo docker run -t --name buildserver -p 21:21 -p 30000-30009:30000-30009 $1

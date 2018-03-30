#!/bin/bash

sudo su
yum update -y

#install base software
yum install git -y
yum install httpd -y
yum install php -y
yum install cmake -y #this is a requirement for armadillo - linear algebra library
yum groupinstall "Development Tools" -y


# https://s3-us-west-1.amazonaws.com/vader-lab/gridlabd-dependencies/install-base.sh

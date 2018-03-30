#!/bin/bash

yum update -y

#install base software
yum install git -y
yum install httpd -y
yum install php -y
yum install cmake -y #this is a requirement for armadillo - linear algebra library
yum groupinstall "Development Tools" -y

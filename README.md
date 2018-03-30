# gridlabd-aws-install
GridLab-D installation script on Amazon Linux


### Licensing Information:

### Author and Contributor List:
* Mayank Malik (http://github.com/malikmayank)
* David Chassin (http://github.com/dchassin)

### File List:


### Support Notes:
These installation scripts has been tested for GridLab-D release *slac-aws-1.0* and *Amazon Linux AMI 2017.09.1*

Scripts are not actively maintained to support newer versions of GridLab-D, Amazon Linux, and/or other prerequisite software.

### Installation Steps:
1. Launch a new EC2 instance with Amazon Linux AMI
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html
2. Open an SSH client
3. Locate your private key file. Your key must not be publicly viewable for SSH to work. Use this command if needed: `chmod 400 [keyfilename].pem`
4. Connect to the instance using it's public DNS:
`ssh -i "[keyfilename].pem" ec2-user@[Public IP address of instance]`
5. Elevate privileges to su:
`sudo su`
6. Clone *scripts* folder from this Git repository:
`git clone https://github.com/malikmayank/gridlabd-aws-install scripts`
7. Install prerequisites:
`sh scripts/install-base.sh`
8. Install MySQL server, connector, and libraries:
`sh scripts/install-mysql.sh`
9. Clone GridLab-D source code from release 'slac-aws-1.0':
```
cd /home/ec2-user
mkdir gridlabd
cd gridlabd
git clone https://github.com/dchassin/gridlab-d source
```
10. Install lib-xercesc C++ Library:
```
cd /home/ec2-user/gridlabd/source/third_party/
. install_xercesc
```
11. Install Armadillo, a linear algebra library:
`sh scripts/install-armadillo.sh`
12. Clone IEEE123 model in www folder:
```
cd /var/www/html
git clone https://github.com/dchassin/ieee123-aws
cp -R ieee123-aws/* .
rm -rf ieee123-aws/
mkdir data output
chmod -R 777 data output config
chown -R apache.apache .
```
13. Install GridLab-D:
```
cd /home/ec2-user/gridlabd/source
autoreconf -isf
./customize configure
make install
export PATH=/usr/local/bin:$PATH
gridlabd --validate
```
14. Configure MySQL. Open my.cnf for editing `nano /etc/my.cnf`and add the following text:
```
[client]
port=3306
socket=/tmp/mysql.sock
[mysqld]
port=3306
datadir=/var/lib/mysql
socket=/tmp/mysql.sock
```
Save and close file.

15. Change file permissions on /etc/my.cnf:
`chmod 755 /etc/my.cnf`

16. Restart MySQL service:
`service mysqld restart`

17. Open MySQL console `mysql` and run the following query:
```
CREATE USER 'gridlabd'@'localhost' IDENTIFIED BY '[password]';
GRANT ALL PRIVILEGES ON *.* TO 'gridlabd'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE USER 'gridlabd_ro'@'%' IDENTIFIED BY '[password]';
GRANT SELECT ON *.* TO 'gridlabd_ro'@'%';
FLUSH PRIVILEGES;
```
18. Restart Apache service:
`service httpd start`

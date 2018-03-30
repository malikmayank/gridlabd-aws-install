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
5. Clone *scripts* folder from this Git repository:
`git clone https://github.com/malikmayank/gridlabd-aws-install scripts`
6. Install prerequisites:
`sh scripts/install-base.sh`
7. Install MySQL server, connector, and libraries:
`sh scripts/install-mysql.sh`
8. Clone GridLab-D source code from release 'slac-aws-1.0':
`sh scripts/copy-gridlabd-source.sh`
9. Install lib-xercesc C++ Library:
`sh scripts/install-libxercesc.sh`
10. Install Armadillo, a linear algebra library:
`sh scripts/install armadillo.sh`
11. Clone IEEE123 model in www folder:
`sh scripts/copy-ieee123.sh`
12. Install GridLab-D:
`sh scripts/install-gridlabd.sh`
13. Configure Apache server:
`sh scripts/configure-http.sh`
14. Configure MySQL:
`sh scripts/configure-mysql.sh`
15. Restart Apache service:
`service httpd start`

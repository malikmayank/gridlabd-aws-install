cd /var/www/html
git clone https://github.com/dchassin/ieee123-aws
cp -R ieee123-aws/* .
rm -rf ieee123-aws/
mkdir data output
chmod -R 777 data output config
chown -R apache.apache .

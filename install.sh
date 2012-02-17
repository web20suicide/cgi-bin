#!/bin/sh
#
# Copyright (C) 2011 Fresco Gamba

# install script for web20.suicidebuntu pulls in all the things which are needed 
# please make sure to answer all questions with yes when installing mysql and phpmyadmin
# includes a git checkout to stay up-to-date with respective changes on community updates 

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# pull in all the packages we need to get things going
aptitude install -y apache2
aptitude install -y python-mysqldb mysql-client python-setuptools
# aptitude install phpmyadmin
aptitude install -y openjdk-6-jre-headless
aptitude install -y libapache2-mod-python libapache2-mod-php5
aptitude install -y firefox 
aptitude install -y deborphan sendmail sasl2-bin
aptitude install autoclean

# allow everyone to be a killer
xhost +
echo "username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# configure sendmail
echo "127.0.0.1       localhost.localdomain  localhost" >> /etc/hosts
echo "FEATURE('always_add_domain')dnl" >> /etc/mail/sendmail.mc
echo "MASQUERADE_AS('moddr.net')dnl" >> /etc/mail/sendmail.mc
echo "FEATURE('allmasquerade')dnl" >> /etc/mail/sendmail.mc
echo "FEATURE('masquerade_envelope')dnl" >> /etc/mail/sendmail.mc
echo "dnl # MAILER_DEFINITIONS" >> /etc/mail/sendmail.mc
echo "MAILER('local')dnl" >> /etc/mail/sendmail.mc
echo "MAILER('smtp')dnl" >> /etc/mail/sendmail.mc

# compile new sendmail configuration
cd /etc/mail/
make

# getting apache ready
sed -e 's/User\s${APACHE_RUN_USER}$/User killer/g' /etc/apache2/apache2.conf > /tmp/apache2.conf
mv /tmp/apache2.conf /etc/apache2/apache2.conf
a2enmod php5 
a2enmod python
/etc/init.d/apache2 restart
# autostart apache2
update-rc.d apache2 defaults

# cleaning up
deborphan | xargs sudo apt-get -y remove –purge

# prepare plymouth
rm w2sm_plymouth.*tar
wget http://www.suicidemachine.org/download/w2sm_plymouth.tar && tar -C / -xvf w2sm_plymouth.tar
update-alternatives --install /lib/plymouth/themes/default.plymouth default.plymouth /lib/plymouth/themes/w2sm/w2sm.plymouth 100
update-alternatives --set default.plymouth /lib/plymouth/themes/w2sm/w2sm.plymouth
update-initramfs -u

# change GTK About screen
rm -rf gnome-about.tar
wget http://www.suicidemachine.org/download/gnome-about.tar && tar -C / -xvf gnome-about.tar

# change bootloader
wget http://www.suicidemachine.org/download/isolinux-buntu.tar
tar -C /etc/remastersys/ -xvf isolinux-buntu.tar

# install selenium web driver python bindings
wget http://pypi.python.org/packages/source/s/selenium/selenium-2.19.1.tar.gz#md5=fc856390a87800c463c7e2d3800e3112
tar -xvf selenium-2.19.1.tar.gz
cd selenium-2.19.1/
python setup.py install

# back to home
cd ../
# for FIREFOX please install Selenium IDE (have to be done manually!)
# wget http://release.seleniumhq.org/selenium-ide/1.6.0/selenium-ide-1.6.0.xpi
# firefox -install-global-extension selenium-ide-1.6.0.xpi 

mkdir /var/www/tmp/ && mkdir /var/www/w2sm

# create suicidemachine working directories
cd /var/www/w2sm/
chown -R killer:killer /var/www/*
chown -R killer:killer /var/www/tmp
chown -R killer:killer /usr/lib/cgi-bin/*

# init & configure git && git pull
git init
git config --global github.user killer
git config --global user.email killer@moddr.net
git remote add origin git@github.com:web20suicide/w2sm.git
git pull

cd /usr/lib/cgi-bin/

git init
git config --global github.user killer
git config --global user.email killer@moddr.net
git remote add origin git@github.com:web20suicide/cgi-bin.git
git pull

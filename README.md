These are the source files from WANem (http://wanem.sourceforge.net/). 

Update 2016.08.23 : WANem Beta 3.0.3. >> These files are corrected for the depedency on a debian 8 environment based on Beta 3.0.2.

----------------

WANem is a Wide Area Network Emulator, meant to provide a real experience of a Wide Area Network/Internet, during application development / testing over a LAN environment. Typically application developers develop applications on a LAN while the intended purpose for the same could be, clients accessing the same over the WAN or even the Internet. WANem thus allows the application development team to setup a transparent application gateway which can be used to simulate WAN characteristics like Network delay, Packet loss, Packet corruption, Disconnections, Packet re-ordering, Jitter, etc. WANem can be used to simulate Wide Area Network conditions for Data/Voice traffic and is released under the widely acceptable GPL v2 license. WANem thus provides emulation of Wide Area Network characteristics and thus allows data/voice applications to be tested in a realistic WAN environment before they are moved into production at an affordable cost. WANem is built on top of other FLOSS [Free Libre and OpenSource] components and like other intelligent FLOSS projects has chosen not to re-invent the wheel as much as possible.

From a functionality perspective WANem hooks into the Linux kernel towards provisioning the network emulation characteristics and extends the functionality with additional modules. Based on a re-mastered Knoppix cd WANem allows quick and easy setup in any development environment with an intuitive web interface for purposes of configuration.

WANEM is Open Source software licensed under the GNU General Public License. You are free to download WANem and use it in your own environments. We encourage you to write to us using the SourceForge forums. You may let us know your perspective on scope for improvement, or if you would like to contribute in anyway possible or of course just to drop us a note of encouragement.



-------------------------
Ergänzung Gastentwickler:


WANem install on Linux Mint  
================================================================
Prerequisites: 
    - Internet connection
    - Linux mint 21
================================================================
Install required packages:

sudo apt-get update
sudo apt-get upgrade

sudo apt install git
sudo apt install apache2
sudo apt install php7.2

================================================================
Update Linux Kernel (required for jitter setting to work correctly)

Aktualisierungsverwaltung öffnen
'Ansicht' --> 'Linux Kernel'
Kernel 5.3 oder höher auswählen und installieren

reboot

================================================================
Copy WANem files

cd /home/andreas/Software
git clone https://github.com/gastentwickler/WANem.git
cd /home/andreas/Software/WANem/etc/apache2/sites-available
sudo cp * /etc/apache2/sites-available/
# cd /home/andreas/Software/WANem/etc/php5      vermutlich nicht nötig
# sudo cp -r * /etc/php/7.2/                    vermutlich nicht nötig
cd /home/andreas/Software/WANem/etc
sudo su -c 'less sudoers >> /etc/sudoers'
sudo cp -r /home/andreas/Software/WANem/root/* /root/
sudo cp -r /home/andreas/Software/WANem/var/* /var/

================================================================
Adjust php Config
in der Datei /etc/php/7.2/apache2/php.ini  den Eintrag "short_open_tag = On"  setzen
in der Datei /etc/php/7.2/cli/php.ini  den Eintrag "short_open_tag = On"  setzen

================================================================
Adjust Apache Config

sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

sudo nano /etc/apache2/sites-enabled/000-default.conf
ab Zeile 54  <VirtualHost *:443>  auskommentieren und speichern

systemctl restart apache2

================================================================
WANem Config
Browser "http://localhost/WANem/"

================================================================
Information zu php debugging:
https://www.nequalsonelifestyle.com/2022/08/08/setting-up-apache-php-with-xdebug/










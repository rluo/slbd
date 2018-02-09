# install desktop
sudo apt-get install ubuntu-desktop
sudo apt-get install gnome-panel gnome-settings-deamon gnome-terminal vnc4server
## change firewall rules
sudo ufw allow 5901:5910/tcp

# VNC
## start vncserver  with size  1024x768
vncserver -geometry 1024x768

## add to the file .vnc/xstartup and comment out the last two lines
gnome-panel &
gnome-settings-deamon &
metacity &
nautilus &
gnome-terminal &
## change network to allow all traffic 


# Data disk
## make sure your data disk is attached
sudo cfdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb1

# install R
sudo apt-get update
sudo apt-get install r-base r-base-dev r-base-html

# Download python anaconda from website or using the script below
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh
source ~/.bashrc

# R web interface
## Follow the instructions for R studio server from R Studio Website
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
sudo gdebi rstudio-server-1.1.423-amd64.deb

## setting up username/password
sudo passwd xi_rossi_luo
## change your firewall rules to allow tcp:8787 or allow all protocols
## access your website from xxx.xxx.xxx.xxx:8787 where xxx- is your VM ip

# R Selenium install

# Spark install

# Zeppelin install

# TensorFlow install




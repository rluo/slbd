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

## Spark install
# Install java
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

# Install sbt
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

# Install spark
wget -c http://apache.claz.org/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz
tar xzvf spark-2.2.1-bin-hadoop2.7.tgz
mv spark-2.2.1-bin-hadoop2.7/ spark
sudo mv spark /usr/lib/
cd /usr/lib/spark/conf
cp spark-env.sh.template spark-env.sh

# Configure network settings
sudo sh -c "echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo sh -c "echo 'net.ipv6.conf.defaults.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo sh -c "echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.conf"

# Configure Spark
echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> spark-env.sh
echo "SPARK_WORKER_MEMORY=8g" >> spark-env.sh

# Add binaries to path
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
echo "export SBT_HOME=/usr/share/sbt/bin/sbt-launch.jar" >> ~/.bashrc
echo "export SPARK_HOME=/usr/lib/spark" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin:/usr/share/sbt/bin/:\$SPARK_HOME/bin" >> ~/.bashrc
source ~/.bashrc

# Zeppelin install

# TensorFlow install
pip install numpy --upgrade
pip install tensorflow



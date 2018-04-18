#0. update your software list, a good practice to run this command 
sudo apt-get update

#1. install desktop
sudo apt-get install ubuntu-desktop
sudo apt-get install gnome-panel gnome-settings-daemon gnome-terminal vnc4server
## change firewall rules
sudo ufw allow 5901:5910/tcp

## add the following test to the file .vnc/xstartup and comment out the last two lines
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &

#2. On GC web interface: change network to allow all traffic 

#3. VNC
## start vncserver  with size  1024x768
## Access by connecting to xxx.xxx.xxx.xxx:5901
# Stop vncserver with vncserver -kill :1
vncserver -geometry 1024x768

#4A. Data disk (optional) 
## make sure your data disk is attached
sudo mkdir -p /mnt/data/
sudo cfdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb1
sudo mount /dev/sdb1 /mnt/data/

# To check, run:
df -h

#4B. Alternative 4A, you could increase the disk to 256GB

#5A.  install default R
sudo apt-get update
sudo apt-get install r-base r-base-dev r-base-html

#5B. alternative: install R from source packages
wget -c https://cran.r-project.org/src/base/R-3/R-3.4.3.tar.gz
tar xvf R-3.4.3.tar.gz
## install x window development files
sudo apt-get install libx11-dev  xorg-dev
sudo apt-get install libcurl4-openssl-dev
## install JAVA
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java9-installer oracle-java9-set-default
## compile and install R
cd R-3.4.3
./configure --prefix=/home/x
i_rossi_luo/Programs/R-3.4.3
make
make install

#5C. R web interface
## Follow the instructions for R studio server from R Studio Website
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
sudo gdebi rstudio-server-1.1.423-amd64.deb
## setting up username/password
sudo passwd xi_rossi_luo
## change your firewall rules to allow tcp:8787 or allow all protocols
## access your website from xxx.xxx.xxx.xxx:8787 where xxx- is your VM ip


#6. R Selenium install
#6A. First upgrade version of default R
sudo sh -c "echo 'deb http://cran.case.edu/bin/linux/ubuntu $(lsb_release -c -s)/' >> /etc/apt/sources.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo add-apt-repository ppa:marutter/rdev

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install r-base

#6B. Alternative to 6A, if you did 5B,
sudo apt-get install libcurl4-openssl-dev libxml2-dev libgeos-dev libssl-dev
cd ~/Programs/R-3.4.3/bin
./R
### Once inside the R interpreter, enter the following command and pick a mirror:
> install.packages("RSelenium")




#7.Download python anaconda from website or using the script below
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh
source ~/.bashrc


#8. Spark install
# Install java
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

# Install sbt
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

# Download and unpack spark and move it into /usr/lib
cd ~/Downloads
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
cd /usr/lib/spark/conf
cp spark-env.sh.template spark-env.sh
echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> spark-env.sh
echo "SPARK_WORKER_MEMORY=1g" >> spark-env.sh
echo "SPARK_WORKER_CORES=2" >> spark-env.sh
echo "SPARK_WORKER_INSTANCES=2" >> spark-env.sh
mkdir -p ~/ssd/spark/
echo "SPARK_WORKER_DIR=~/ssd/spark" >> spark-env.sh

# setup spark cluster mode
/usr/lib/spark/sbin/start-master.sh
cd ~/.ssh
ssh-keygen
cat id_rsa.pub  >> authorized_keys
/usr/lib/spark/sbin/start-slaves.sh

# Add binaries to path
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
echo "export SBT_HOME=/usr/share/sbt/bin/sbt-launch.jar" >> ~/.bashrc
echo "export SPARK_HOME=/usr/lib/spark" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin:/usr/share/sbt/bin/:\$SPARK_HOME/bin" >> ~/.bashrc
source ~/.bashrc

#8B. install python numpy 
sudo apt-get install python-pip  
sudo -H pip install numpy scipy
sudo -H pip install --upgrade pip

#8C. Zeppelin install
cd ~/ssd

# Download and unpack Zeppelin
wget -c http://mirror.cc.columbia.edu/pub/software/apache/zeppelin/zeppelin-0.7.3/zeppelin-0.7.3-bin-all.tgz
tar zxvf zeppelin-0.7.3-bin-all.tgz
mv zeppelin-0.7.3-bin-all zeppelin

# Create env file from template
cd zeppelin/conf/
cp zeppelin-env.sh.template zeppelin-env.sh

# Populate env file
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> zeppelin-env.sh
echo "export SPARK_HOME=/usr/lib/spark" >> zeppelin-env.sh
echo "export ZEPPELIN_PORT=8099" >> zeppelin-env.sh

# Replace port number and start daemon
sed -i 's/8080/8099/' zeppelin-site.xml.template
../bin/zeppelin-daemon.sh start

# install R package knitr, data.table, googleVis if you want to try the R spark tutorial


#9. TensorFlow install
pip install numpy --upgrade
pip install tensorflow


#10. Jupyter
sudo pip -H install jupyter
sudo apt-get install python3-pip
sudo -H ipython3 kernelspec install-self
sudo -H pip3 install numpy scipy
sudo -H pip3 install tensorflow
sudo -H pip3 install matplotlib
sudo -H pip3 install sklearn
jupyter notebook --generate-config
nano ~/.jupyter/jupyter_notebook_config.py
echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 1717" >> ~/.jupyter/jupyter_notebook_config.py
sudo -H pip3 install jupyter







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
## access your website from xxx.xxx.xxx.xxx:8787 where xxx- is your VM ip


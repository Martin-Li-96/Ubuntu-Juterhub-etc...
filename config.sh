#!/bin/bash
#Ubuntu 22.04 LTS
gnome-terminal --window --title="CONF_STEP1" -- bash -c "sudo mkdir /opt/config && cd /opt/config;sudo wget -P /opt/config https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh;sudo sh /opt/config/Anaconda3-2022.05-Linux-x86_64.sh;gnome-terminal --window --title='CONF_STEP2' -- bash -c 'sudo su - <<'EOF'
echo config-step 2 start
cd /opt/config
sudo apt update -y
sudo apt upgrade -y
sudo install curl -y 
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install npm -y


#R language Support
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/'
sudo apt install --no-install-recommends r-base
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
apt install --no-install-recommends r-cran-rstan

#Rstudio-Server
sudo apt-get install gdebi-core
wget -P /opt/config https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.1-554-amd64.deb
sudo gdebi /opt/config/rstudio-server-2022.07.1-554-amd64.deb

#code-server
curl -fsSL https://code-server.dev/install.sh | sh




EOF;'" 

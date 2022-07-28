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
#Nvidia-cuda-toolkit
sudo apt install -y nvidia-cuda-toolkit

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
sudo apt install -y --no-install-recommends r-base
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
sudo apt install -y --no-install-recommends r-cran-rstan 
sudo apt install gfortran -y


#Rstudio-Server
sudo apt-get install gdebi-core
wget -P /opt/config https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.1-554-amd64.deb
sudo gdebi /opt/config/rstudio-server-2022.07.1-554-amd64.deb
rstudio-server start

#code-server
curl -fsSL https://code-server.dev/install.sh | sh

#Orcal JDK18
wget -P /opt/config https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.deb
dpkg -i /opt/config/jdk-18_linux-x64_bin.deb
cat <<'EOF_in' >> /etc/profile
export JAVA_HOME=/usr/lib/jvm/jdk-18
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOMR/bin
EOF_in
source /etc/profile

#octave
sudo apt install octave -y
sudo apt --fix-broken install -y
sudo apt install octave -y


#Config jupyterhub and install kernel
conda update conda -y
conda create -n jp --clone base
conda activate jp
pip install jupyterhub jupyterlab
npm install -g configurable-http-proxy
pip install ipywidgets
yum install octave -y
jupyter labextension install @jupyterlab/hub-extension
pip install jupyter-server-proxy
pip install jupyter-vscode-proxy
pip install jupyter-rsession-proxy
pip install jupyter-c-kernel
install_c_kernel
cp -r /root/.local/share/jupyter/kernels/c /opt/anaconda3/envs/jp/share/jupyter/kernels/c
conda install octave_kernel -c conda-forge -y
conda install texinfo -y
python -m octave_kernel install
conda create -n C++ -y
conda activate C++
conda install conda -y
pip install ipykernel
conda install xeus-cling -c conda-forge -y
cp -r /opt/anaconda3/envs/C++/share/jupyter/kernels/xcpp11 /opt/anaconda3/envs/jp/share/jupyter/kernels/xcpp11
cp -r /opt/anaconda3/envs/C++/share/jupyter/kernels/xcpp14 /opt/anaconda3/envs/jp/share/jupyter/kernels/xcpp14
cp -r /opt/anaconda3/envs/C++/share/jupyter/kernels/xcpp17 /opt/anaconda3/envs/jp/share/jupyter/kernels/xcpp17
conda create -n fortran -y
conda activate fortran 
conda install conda -y
pip install ipykernel
conda install lfortran -c conda-forge -y
cp -r /opt/anaconda3/envs/fortran/share/jupyter/kernels/fortran /opt/anaconda3/envs/jp/share/jupyter/kernels/fortran



EOF;'" 

## This is a new version of Neuron box

#Update dependencies
sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install python3-dev -y
sudo apt-get install zlib1g-dev -y
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y


# Install Python
sudo wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
sudo tar -xzf Python-3.6.4.tgz

cd Python-3.6.4

sudo ./configure
sudo make
sudo make install

# Install IPython Notebook dependencies
sudo pip3.6 install numpy scipy matplotlib
sudo pip3.6 install pandas scikit-learn ipython pyyaml
sudo pip3.6 install jupyter jupyterlab tqdm

#Install libraries for scipy
sudo apt-get install gfortran libopenblas-dev liblapack-dev --assume-yes

# IV dependencies
sudo apt-get install automake -y
sudo apt-get install libxt-dev -y
sudo apt-get install autoconf -y
sudo apt-get install libxext-dev -y
sudo apt-get install libncurses-dev -y
sudo apt-get install bison -y
sudo apt-get install libtool -y
sudo apt-get install flex -y

# Neuron dependencies
sudo apt-get install mercurial -y

#Install NEURON
cd ..
mkdir neuron
cd neuron
wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.3/nrn-7.3.tar.gz
wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.3/iv-18.tar.gz
tar -xzf nrn-7.3.tar.gz
tar -xzf iv-18.tar.gz

#Rename
mv iv-18 iv
mv nrn-7.3 nrn

#Installs iv into /usr/local/x86_64/lib
cd iv
./configure --prefix=/usr/local
sudo make
sudo make install
cd ..

# Patch Neuron for Python 3.4
sudo patch /home/vagrant/neuron/nrn/src/nrnpython/nrnpython.cpp /vagrant/nrnpython.diff
sudo patch /home/vagrant/neuron/nrn/src/oc/hoc.c /vagrant/hoc.diff

# Install Neuron
cd nrn
./configure --prefix=/usr/local --with-iv=/usr/local/x86_64/ --with-nrnpython=/usr/local/bin/python3.6
sudo make
sudo make install
 
# Install Python with Neuron
cd src/nrnpython
sudo python3.6 setup.py install

#Take all mods and compile them
sudo cp /vagrant/Mods/* /usr/local/x86_64/bin/
cd /usr/local/x86_64/bin/
echo PATH $PATH
[ -f ~/.profile ] || touch ~/.profile
[ -f ~/.bash_profile ] || touch ~/.bash_profile
grep 'PATH=/usr/local/x86_64/bin' ~/.profile || echo 'export PATH=/usr/local/x86_64/bin:$PATH' | tee -a ~/.profile
grep 'PATH=/usr/local/x86_64/bin' ~/.bash_profile || echo 'export PATH=/usr/local/x86_64/bin:$PATH' | tee -a ~/.bash_profile
. ~/.profile
. ~/.bash_profile
echo PATH $PATH
sudo nrnivmodl
sudo /usr/local/x86_64/bin/nrnivmodl

# Run IPython Notebook
cd /vagrant/
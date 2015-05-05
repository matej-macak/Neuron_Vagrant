#Update dependencies
sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install python3-dev -y
sudo apt-get install python-dev -y

# Requirements for matplotlib
sudo apt-get install freetype* -y
sudo apt-get install pkg-config -y

#Install pip
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python3
sudo easy_install pip

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

# Install python libraries
sudo pip3 install numpy
sudo pip3 install pandas
sudo pip3 install scipy
sudo pip3 install scikit-learn
sudo pip3 install ipython
sudo pip3 install ipython --upgrade
sudo pip3 install pyparsing
sudo pip3 install pyparsing --upgrade
sudo pip3 install matplotlib
sudo pip3 install pyyaml

# Install IPython Notebook dependencies
sudo pip3 install pyzmq
sudo pip3 install tornado
sudo pip3 install jinja2
sudo pip3 install jsonschema

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
sudo patch /home/neuron/nrn/src/nrnpython/nrnpython.cpp /vagrant/nrnpython.diff
sudo patch /home/neuron/nrn/src/oc/hoc.c /vagrant/hoc.diff

# Install Neuron
cd nrn
./configure --prefix=/usr/local --with-iv=/usr/local/x86_64/ --with-nrnpython=/usr/bin/python3
sudo make
sudo make install
 
# Install Python with Neuron
cd src/nrnpython
sudo python3 setup.py install

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
sudo ipython notebook --port=8890 --ip=0.0.0.0

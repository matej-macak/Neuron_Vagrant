#Update dependencies
sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install python-dev -y

#Install pip
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python
sudo easy_install pip

#Install libraries for scipy
sudo apt-get install gfortran libopenblas-dev liblapack-dev --assume-yes

#Install major libraries
sudo pip install numpy
sudo pip install pandas
sudo pip install scipy
sudo pip install scikit-learn
sudo pip install ipython
sudo pip install ipython --upgrade
sudo pip install pyparsing
sudo pip install pyparsing --upgrade

#Dependencies install for matplotlib
sudo apt-get install python-dev -y
sudo apt-get install freetype* -y
sudo apt-get build-dep matplotlib -y
sudo apt-get install libicu48 #To get rid of annoying icui18n error in matplotlib

#Install matplotlib
sudo pip install matplotlib

# IV dependencies
sudo apt-get install automake -y
sudo apt-get install libxt-dev -y
sudo apt-get install autoconf -y
sudo apt-get install libxext-dev -y
sudo apt-get install libncurses-dev -y
sudo apt-get install bison -y
sudo apt-get install libtool -y
sudo apt-get install flex -y

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

#Install Neuron
cd nrn
./configure --prefix=/usr/local --with-iv=/usr/local/x86_64/ --with-nrnpython=/usr/bin/python
sudo make
sudo make install

#Install Python extension
cd src/nrnpython
sudo python setup.py install

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

#Install ipython modules and dependencies
sudo pip install pyzmq
sudo pip install tornado
sudo pip install tornado --upgrade
sudo pip install jinja2
sudo pip install jsonschema

#Launch IPython Notebook server
cd /vagrant/
sudo ipython notebook --ip=0.0.0.0 --port=8900
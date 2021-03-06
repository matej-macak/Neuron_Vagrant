# Installation

The installation of Vagrant with Neuron and Docker images with optional installation of Mods located in `Mods` directory. 

# Vagrant

## Quick start (for 64-bit machines):

1. Install Virtual Box if you haven't already - instructions to which you can find [here](https://www.virtualbox.org/wiki/Downloads).
2. Install [Vagrant](http://www.vagrantup.com/)
3. Clone this repository by `git clone https://github.com/matej-macak/Neuron_Vagrant/` or by downloading zip file and unpacking.
4. Navigate to the directory of interest and run `vagrant up`
5. When the installation finishes (this will take a while), simply open your browser and type the following: `http://localhost:8000/` (irrespective of installation type).
6. Load neuron library with `import neuron` or `from neuron import h`

## Under the hood

1. Vagrant installs `ubuntu/trusty64` (or `ubuntu/xenial64` for Python 3.6) virtual box to serve as the environment for NEURON building. 
2. provision.sh is called during the installation which then proceeds to install major scientific python libraries apart from NEURON including numpy, scipy, matplotlib, pandas and sklearn. Other libraries can be easily installed with sudo pip install <library> command. 
3. Mod files are then compiled which were stored in `/Mods` folder using the `nrnivmodl` command
4. Finally, jupyter notebook (or jupyter lab for Python3.6 and Docker) is run via `port 8000`. 

## Troubleshooting

### 32-bit systems
This installation requires a 64-bit machine to run. In case 32-bit is required, just change the name of the box and the address to download the box from. For the list of vagrant boxes, see [here](http://www.vagrantbox.es/). At the moment, 32-bit system is untested.

# Docker

## Quick start

1. Install Virtual Box
2. Install Docker Toolbox (or Docker for Windows)
3. Clone this repository (as detailed above)
4. Navigate to the `Docker` directory `Base_Box` and run `docker build -t neuron .`
5. Navigate to the `Neuron_w_Mods` directory and run `docker build -t exp .`
6. Run `docker run -it -v <path to directory to be shared>:/shared -p 8888:8888 exp`

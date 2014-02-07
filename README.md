# Installation

The installation of Vagrant with Neuron is pretty straightforward and easy (which was one of the main reasons for creating the project). 

## Quick start (for 64-bit machines):

1. Install Virtual Box if you haven't already - instructions to which you can find [here](https://www.virtualbox.org/wiki/Downloads).
2. Install [Vagrant](http://www.vagrantup.com/)
3. Clone this repository by `git clone https://github.com/matej-macak/Neuron_Vagrant/` or by downloading zip file and unpacking.
4. Navigate to the directory of interest and run `vagrant up`
5. When the installation finishes (this will take a while), simply open your browser and type the following: http://localhost:8888/
6. Load neuron library with `import neuron` or `from neuron import h`

## Under the hood

1. Vagrant installs precise64 virtual box to serve as the environment for NEURON building. 
2. provision.sh is called during the installation which then proceeds to install major scientific python libraries apart from NEURON including numpy, scipy, matplotlib, pandas and sklearn. Other libraries can be easily installed with sudo pip install <library> command. 
3. Mod files are then compiled which were stored in `/Mods` folder using the `nrnivmodl` command
4. Finally, ipython and ipython notebook is run via `port 8888`. 

##Troubleshooting

###32-bit systems
This installation requires a 64-bit machine to run. In case 32-bit is required, just change the name of the box and the address to download the box from. For the list of vagrant boxes, see [here](http://www.vagrantbox.es/). At the moment, 32-bit system is untested.

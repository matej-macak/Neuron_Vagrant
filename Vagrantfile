# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

config.vm.box = "precise64"
config.vm.box_url = "http://files.vagrantup.com/precise64.box"   

config.vm.network "forwarded_port", guest: 8888, host: 8888

config.vm.provision "shell", path: "provision.sh"

#Change path in the provisioning                                                           
#config.vm.provision :shell, :inline => "echo PATH $PATH"
#config.vm.provision :shell, :inline => "[ -f ~/.profile ] || touch ~/.profile"
#config.vm.provision :shell, :inline => "[ -f ~/.bash_profile ] || touch ~/.bash_profile"
#config.vm.provision :shell, :inline => "grep 'PATH=/usr/local/x86_64/bin' ~/.profile || echo 'export PATH=/usr/local/x86_64/bin:$PATH' | tee -a ~/.profile"
#config.vm.provision :shell, :inline => "grep 'PATH=/usr/local/x86_64/bin' ~/.bash_profile || echo 'export PATH=/usr/local/x86_64/bin:$PATH' | tee -a ~/.bash_profile"
#config.vm.provision :shell, :inline => ". ~/.profile"
#config.vm.provision :shell, :inline => ". ~/.bash_profile"
#config.vm.provision :shell, :inline => "echo PATH $PATH"
#config.vm.provision :shell, :inline => "sudo /usr/local/x86_64/bin/nrnivmodl"

config.ssh.forward_agent = true
#config.vm.provision "shell", path: "provision_after.sh" 

end


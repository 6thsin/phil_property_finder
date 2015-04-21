# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network "private_network", ip: "192.168.100.222"
  # config.vm.network "forwarded_port", guest: 8000, host: 8080

  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p /etc/puppet/modules;
                    mkdir -p /python_environments;
                    function install_module {
                      folder=`echo $1 | sed s/.*-//`
                      if [ ! -d /etc/puppet/modules/$folder ]; then
                        puppet module install $1
                      fi
                    }
                    install_module willdurand/nodejs
                    install_module puppetlabs-git
                    install_module stankevich-python
                    install_module puppetlabs-mysql"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
    # puppet.module_path = "puppet/modules"
  end

end

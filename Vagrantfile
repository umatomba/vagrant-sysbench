# -*- mode: ruby -*-
# vi: set ft=ruby : 

def provision_node()
    setup = <<-SCRIPT
echo mysql-server mysql-server/root_password password root | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password root | sudo debconf-set-selections
sudo apt-get  -q -y update
sudo apt-get  -q -y install python-software-properties vim curl wget tmux socat
sudo apt-get -o Dpkg::Options::='--force-confnew' -qqy install postgresql postgresql-contrib libpq-dev bzr automake libtool make mysql-server libmysqlclient-dev
sudo service mysql stop
bzr branch lp:sysbench
cd /home/vagrant/sysbench/
sudo ./autogen.sh && ./configure --prefix=/usr --with-pgsql && make && make install
    SCRIPT
end

Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/precise64"
    config.ssh.username = "vagrant"
    config.ssh.password = "vagrant"
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 1
    end
    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
        config.cache.enable :apt
    end

        config.vm.define "sb" do |box|
            box.vm.hostname = "sb"
            box.vm.network :public_network, ip: "172.16.0.222", bridge: "eth1"
            box.vm.provision :shell, :inline => provision_node()
        end
end

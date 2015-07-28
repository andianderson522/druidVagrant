# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.4.2"

$local_username ||= `whoami`.strip

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "chef/centos-7.0"
	#config.vm.box_url = "https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.1.0/centos-7.0-x86_64.box"
	config.vm.provision :shell, :path => "bootstrap.sh", :args => $local_username
	config.vm.box_check_update = true

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "4048"]
		vb.customize ["modifyvm", :id, "--cpus", "2"]
	end

	config.vm.define "druid" do |druid|
		druid.vm.host_name = "druid.conde.vm"
		#druid.vm.network "private_network", ip: "192.168.2.104"
		druid.vm.network "forwarded_port", guest: 8081, host: 8081
		druid.vm.network "forwarded_port", guest: 2181, host: 2181
		druid.vm.network "forwarded_port", guest: 3306, host: 3307
		#style.vm.network "forwarded_port", guest: 11420, host: 11420
		#style.vm.network "forwarded_port", guest: 12420, host: 12420
		#style.vm.network "forwarded_port", guest: 11750, host: 11750
		#style.vm.network "forwarded_port", guest: 11740, host: 11740
		#style.vm.network "forwarded_port", guest: 8998, host: 8998
		#style.vm.network "forwarded_port", guest: 1099, host: 1099
		druid.vm.synced_folder "./deployment", "/cn/deployment"
		#style.vm.synced_folder "./deployment/ftpRoot", "/cn/content/ftpdata", owner: "cnp", group: "cnp-admin"
		# solr.vm.provision :shell, :inline => "service cnresin-solrcloud restart"
	end
end

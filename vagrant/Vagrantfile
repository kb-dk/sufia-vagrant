# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "phusion"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos/7"

=begin
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # Tomcat
  config.vm.network :forwarded_port, guest: 8181, host: 8181 # Karaf
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # MySQL
  config.vm.network :forwarded_port, guest: 5432, host: 5432 # PostgreSQL
=end
  config.vm.network :forwarded_port, guest: 80, host: 8000 # Apache


  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 4
  end

  #Correct centos 7 crap
  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provision :shell, :name=> "100bootstrap.sh", :path => "100bootstrap.sh", :privileged => false
  config.vm.provision :shell, :name=> "200rvm.sh", :path => "200rvm.sh", :privileged => false
  config.vm.provision :shell, :name=> "300ruby.sh", :path => "300ruby.sh", :privileged => false
  config.vm.provision :shell, :name=> "350nodejs.sh", :path => "350nodejs.sh", :privileged => false
  config.vm.provision :shell, :name=> "400passenger.sh", :path => "400passenger.sh", :privileged => false
  config.vm.provision :shell, :name=> "500app-deploy.sh", :path => "500app-deploy.sh", :privileged => false
  config.vm.provision :shell, :name=> "600app-env.sh", :path => "600app-env.sh", :privileged => false
  config.vm.provision :shell, :name=> "700app-apache.sh", :path => "700app-apache.sh", :privileged => false

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.define "samba" do |smb|
    smb.vm.box = "geerlingguy/ubuntu2004"
    smb.vm.network "private_network", ip: "192.168.60.10"
    smb.vm.hostname = "samba"

    smb.vm.provider :virtualbox do |vbox|
      vbox.name = "samba"
      vbox.memory = 512
    end
  end
end
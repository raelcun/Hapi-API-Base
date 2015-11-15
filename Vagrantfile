# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
sudo sed -i -e 's/bindIp: 127.0.0.1/#bindIp: 127.0.0.1/g' /etc/mongod.conf
sudo service mongod restart
SCRIPT

Vagrant.configure("2") do |config|

    config.vm.box = "scotch/box"
    config.vm.network "private_network", ip: "192.168.33.10"
    config.vm.hostname = "scotchbox"
    config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
    
    # Optional NFS. Make sure to remove other synced_folder line too
    #config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

    config.vm.provision "shell", inline: $script

end

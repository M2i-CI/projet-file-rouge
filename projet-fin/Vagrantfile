# -*- mode: ruby -*-
# vi: set ft=ruby :

# Getting ssh public key from host
#public_key_path = File.join(Dir.home, ".ssh", "id_rsa.pub")
#public_key = IO.read(public_key_path)
#$script = <<-SCRIPT
#echo '#{public_key}' >> /home/vagrant/.ssh/authorized_keys 
#SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder ".", "/vagrant" , mount_options: ["dmode=700,fmode=600"]
  #executing script to put public key to authorized_keys in vagrant guest
  #config.vm.provision "shell", inline: $script
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
  
  config.vm.define :mvgitlab, autostart: false do |mvgitlab|
    mvgitlab.vm.network :forwarded_port, host: 2202, guest: 22, id: "ssh", auto_correct: true
    mvgitlab.vm.network "private_network", ip: "192.168.33.102"
    mvgitlab.vm.hostname = "mvgitlab"
    mvgitlab.vm.provision "shell", inline: <<-SCRIPT
      echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
      apt-get update && apt-get install -y python
    SCRIPT
    config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    end
  end

  config.vm.define :mvnexus do |mvnexus|
    mvnexus.vm.network :forwarded_port, host: 2203, guest: 22, id: "ssh", auto_correct: true
    mvnexus.vm.network "private_network", ip: "192.168.33.103"
    mvnexus.vm.hostname = "mvnexus"
    mvnexus.vm.provision "shell", inline: <<-SCRIPT
      echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
      apt-get update && apt-get install -y python
    SCRIPT
    config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    end
  end

  (1..3).each do |i|
    config.vm.define "mvcible#{i}" do |mvcible|
      mvcible.vm.network :forwarded_port, host: "220#{i+4}", guest: 22, id: "ssh", auto_correct: true
      mvcible.vm.network "private_network", ip: "192.168.33.12#{i}"
      mvcible.vm.hostname = "mvcible#{i}"
      mvcible.vm.provision "shell", inline: <<-SCRIPT
        echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
        apt-get update && apt-get install -y python
      SCRIPT
      config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      end
    end
  end

  config.vm.define :leader, primary: true do |leader|
    leader.vm.network :forwarded_port, host: 2201, guest: 22, id: "ssh", auto_correct: true
    leader.vm.network "private_network", ip: "192.168.33.101"
    leader.vm.hostname = "leader"
    leader.vm.provision "shell", path: "bootstrap.sh"
    leader.vm.provision "shell", inline: "ansible-playbook /vagrant/ansible/playjenkins.yml -c local"
#    leader.vm.provision "shell", inline: "ansible-playbook /vagrant/ansible/playnexus.yml"
#    leader.vm.provision "shell", inline: "ansible-playbook /vagrant/ansible/playgitlab.yml"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end

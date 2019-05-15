Vagrant.configure("2") do |config|
  #
  # Common Vagrant config
  #

  config.vm.box = "centos/7"

  # Don't sync the local dir (yet)
  config.vm.synced_folder ".", "/vagrant", disabled: true

  #
  # Common VirtualBox config
  #

  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
  end

  #
  # Common ansible config
  #

  $script = <<-SCRIPT
    sudo mkdir -p /nix
    sudo chown vagrant:vagrant /nix
    mkdir -p ~/.config/nix
    echo 'sandbox = false' > ~/.config/nix/nix.conf
    sh <(curl https://nixos.org/nix/install) --no-daemon
    tail -n 1 .bash_profile >> .bashrc
  SCRIPT

  config.vm.provision "shell", privileged: false, inline: $script

  #
  # Systems
  #

  config.vm.define "compute-node" do |system|
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# setting provisioning folder path
vagrant_provisioning_folder="repo_scripts/vagrant_prov"

# setting ip addresses
private_ip_net="192.168.33"
starting_ip=10
victim_linux_ip=starting_ip.next
redir_ip=victim_linux_ip.next
attacker_ip=redir_ip.next

# hostname vars
## doesn't work on windows for some reason...
win_vic_hostname='victim-windows'
lin_vic_hostname='victim-linux'
redir_hostname='redir'
attack_hostname='attacker'

# vagrant boxes
generic_win_box='rapid7/metasploitable3-win2k8'
generic_linux_box='bento/ubuntu-18.04'

# setting boxes
victim_win_box="#{generic_win_box}"
victim_linux_box="#{generic_linux_box}"
redir_box="#{generic_linux_box}"

# setting to my kali vagrant image, because it recieves weekly update
# so you don't have to wait forever to get all kali updates
attacker_box='elrey741/kali-linux_amd64'

Vagrant.configure("2") do |config|

  # victim_win: windows machine getting attacked
  config.vm.define "#{win_vic_hostname}" do |victim_win|

    # defining box value
    victim_win.vm.box = "#{victim_win_box}"

    # setting internal ip address
    victim_win.vm.network "private_network", ip: "#{private_ip_net}.#{starting_ip}"

    # setting hostname so more clear where I am in network
    # victim_win.vm.hostname = "#{win_vic_hostname}"
    victim_win.vm.hostname = "victim-windows"

  end

  # victim_linux: linux machine getting attacked
  config.vm.define "#{lin_vic_hostname}" do |victim_linux|

    # defining box value
    victim_linux.vm.box = "#{victim_linux_box}"

    # setting internal ip address
    victim_linux.vm.network "private_network", ip: "#{private_ip_net}.#{victim_linux_ip}"

    # setting hostname so more clear where I am in network
    victim_linux.vm.hostname = "#{lin_vic_hostname}"

    # provisioning box to update setup items
    victim_linux.vm.provision "shell", path: "#{vagrant_provisioning_folder}/prov.sh"

  end

  # redir: machine used as redirector/bastion host
  config.vm.define "#{redir_hostname}" do |redir|

    # defining box value
    redir.vm.box = "#{redir_box}"

    # setting internal ip address
    redir.vm.network "private_network", ip: "#{private_ip_net}.#{redir_ip}"

    # setting hostname so more clear where I am in network
    redir.vm.hostname = "#{redir_hostname}"

    # provisioning box to update setup items
    redir.vm.provision "shell", path: "#{vagrant_provisioning_folder}/prov.sh"

  end

  # attacker: machine used to attack other hosts
  config.vm.define "#{attack_hostname}" do |attacker|

    # defining box value
    attacker.vm.box = "#{attacker_box}"

    # setting internal ip address
    attacker.vm.network "private_network", ip: "#{private_ip_net}.#{attacker_ip}"

    # setting hostname so more clear where I am in network
    attacker.vm.hostname = "#{attack_hostname}"

    # provisioning box to update setup items
    attacker.vm.provision "shell", path: "#{vagrant_provisioning_folder}/prov.sh"

    # currently should work for all linux machine (will provide link later for OSX and Windows)
    # allowing me to x11 forward applications
    attacker.ssh.forward_agent = true
    attacker.ssh.forward_x11 = true

    # setting vbox specific values
    attacker.vm.provider "virtualbox" do |vb|

      # Display the VirtualBox GUI when booting the machine
      # vb.gui = true

      # Customize the amount of memory on the VM:
      vb.cpus = "2"
      vb.memory = "2048"

    end
  end
end
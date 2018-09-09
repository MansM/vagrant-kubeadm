# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
config_yml = YAML.load_file(File.open(File.expand_path(File.dirname(__FILE__)) + "/vagrant-config.yml"))

Vagrant.configure(2) do |config|

  #config.vm.box = "mansm/CentOS-7"
  config.vm.box = "debian/stretch64"

  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
  end

  config_yml['vms'].each do |name, settings|

    config.vm.define name,  autostart: settings.key?("autostart") ? settings["autostart"] : true  do |vm_config|
      vm_config.vm.hostname = "#{settings["hostname"]}.#{config_yml["config"]["domainname"]}"
      vm_config.vm.network "private_network", ip: "#{config_yml["config"]["iprange"]}.#{settings["ip"]}"
      vm_config.vm.synced_folder "./", "/vagrant"
      vm_config.ssh.insert_key = false

      vm_config.vm.provider "virtualbox" do |vb|
        vb.name = settings["hostname"]
        vb.cpus = settings.key?("cpu") ? settings["cpu"] : 1
        vb.memory = settings.key?("memory") ? settings["memory"] : 512

        if settings.key?("dsize")
          disk_name = "#{name}_disk.vdi"
          disk_size = settings["dsize"]
          controller_name = "SATA Controller"

          unless File.exist?(disk_name)
            vb.customize [ 'createmedium', '--filename', disk_name, '--size', 1024*disk_size ]
          end # unless

          vb.customize [ 'storageattach', :id, '--storagectl', controller_name, '--port', 2, '--device', 0, '--type', 'hdd', '--medium', disk_name ]
        end # extra disk
      end # virtualbox
      if "#{settings["hostname"]}" == config_yml['vms'][config_yml['vms'].keys.last]['hostname']
        if config_yml["config"].key?("ansible")
          config.vm.provision :ansible do |ansible|
            ansible.playbook = config_yml["config"]["ansible"]
            ansible.become = true
            ansible.verbose = "v"
            ansible.host_key_checking = false
            ansible.limit = "all"
            if config_yml["config"].key?("ansiblegroups")
              ansible.groups = config_yml["config"]["ansiblegroups"]
            end # ansible groups
          end # ansible
        end # if ansible
      end # if for last host

    end # vm_config
  end # each vm
end # vagrant
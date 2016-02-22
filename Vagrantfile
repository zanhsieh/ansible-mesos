# -*- mode: ruby -*-
# vi: set ft=ruby :

$IPs = {
  "docker-registry" => "192.168.122.18",
  "mesos-slave3"    => "192.168.122.17",
  "mesos-slave2"    => "192.168.122.16",
  "mesos-slave1"    => "192.168.122.15",
  "mesos-master3"   => "192.168.122.13",
  "mesos-master2"   => "192.168.122.12",
  "mesos-master1"   => "192.168.122.11"
}

$Masters = $IPs.select { |k,v| k.to_s.match(/^mesos-master\d+/) }.keys
$Slaves  = $IPs.select { |k,v| k.to_s.match(/^mesos-slave\d+/) }.keys

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos71-1511"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = "box"
    config.cache.synced_folder_opts = {
      type: "nfs",
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end
  $IPs.map do |k,v|
    config.vm.define "#{k}" do |m|
      m.vm.hostname = "#{k}"
      m.vm.network "private_network", ip: "#{v}"
      case k
      when "mesos-master1"
        m.vm.provision "ansible" do |ansible|
          ansible.playbook = "all.yml"
          ansible.limit = "all"
          ansible.sudo = true
          ansible.groups = {
            "slave" => $Slaves,
            "master" => $Masters,
            "zookeeper" => $Masters,
            "consul_server" => $Masters,
            "consul_client" => $Slaves,
            "docker_registry" => "docker-registry",
          }
        end
      end
    end
  end
end

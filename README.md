# ansible-mesos

## Description
This repository contains Ansible configurations that can be used to bring up
a simple Mesos/Marathon/Chronos cluster with Consul. It will create a cluster 
with 3x masters and 3x slaves. Target platform is CentOS 7.1.

## Instructions
- Pack CentOS 7.1 vagrant box from official iso with Packer (CentOS 7.1 template
  [here](https://github.com/shiguredo/packer-templates), build instruction
  [here](https://www.packer.io/intro/getting-started/build-image.html))

    vagrant box add centos71-1511 /path/to/your/packer_gen_vagrantbox_file.box

- (Optional) Install Vagrant plugin cashier:

    vagrant plugin install vagrant-cachier

- Create ./files directory and download a version jdk rpm as your choice, or
  change `java_download_from_oracle` to `true` in ./roles/sun_jdk/defaults/main.yml
  file.

- Start the cluster with the following commands:

    vagrant up
    ./init-cluster.sh

This will start the 6 Vagrant machines, install a mesos cluster on them,
and install two sample Marathon apps, and a smaple Chronos app. This will take
a long time if it is the first time you have run it as it will have to
download the vm images, the packages and the docker images.

The `./init-cluster.sh` script will add all the files in `task-data/marathon`
to Marathon on the master and all the files in `task-data/chronos` to Chronos.
You can use the existing files in these directories as templates for your own
Marathon and chronos services.

## Details

### registry
- **Role:** Docker Registry
- **OS:** CentOS 7
- **Apps:** Docker, Docker Registry
- **IP:** `192.168.122.18`

### mesos-master1
- **Role:** Master
- **OS:** CentOS 7
- **Apps:** Zookeeper, [Mesos](http://192.168.122.11:5050/), [Marathon](http://192.168.122.11:8080/), [Chronos](http://192.168.122.11:4400/), [Consul](http://192.168.122.11:8500/)
- **IP:** `192.168.122.11`

### mesos-master2
- **Role:** Master
- **OS:** CentOS 7
- **Apps:** Zookeeper, [Mesos](http://192.168.122.12:5050/), [Marathon](http://192.168.122.12:8080/), [Chronos](http://192.168.122.12:4400/), [Consul](http://192.168.122.12:8500/)
- **IP:** `192.168.122.12`

### mesos-master3
- **Role:** Master
- **OS:** CentOS 7
- **Apps:** Zookeeper, [Mesos](http://192.168.122.13:5050/), [Marathon](http://192.168.122.13:8080/), [Chronos](http://192.168.122.13:4400/), [Consul](http://192.168.122.13:8500/)
- **IP:** `192.168.122.13`

### mesos-slave1
- **Role:** Slave
- **OS:** CentOS 7
- **Apps:** Mesos, Docker, Consul, [HAProxy](http://192.168.122.15:9090/)
- **IP:** `192.168.122.15`

### mesos-slave2
- **Role:** Slave
- **OS:** CentOS 7
- **Apps:** Mesos, Docker, Consul, [HAProxy](http://192.168.122.16:9090/)
- **IP:** `192.168.122.16`

### mesos-slave3
- **Role:** Slave
- **OS:** CentOS 7
- **Apps:** Mesos, Docker, Consul, [HAProxy](http://192.168.122.17:9090/)
- **IP:** `192.168.122.17`
Vagrant.configure("2") do |config|
  # config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.define "consul" do |consul|
    consul.vm.provider "docker" do |d|
      d.vagrant_vagrantfile = "docker-consul-host/Vagrantfile"
      d.image = "cargonauts/consul-dns"
      d.cmd = ["/consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /opt/config/ -client 0.0.0.0"]
      d.create_args = ['-d', '-p', '53:53/udp']
    end
  end

  config.vm.define "helloworld" do |helloworld|
    helloworld.vm.provider "docker" do |d|
      d.vagrant_vagrantfile = "docker-consul-host/Vagrantfile"
      d.image = "cargonauts/helloworld-python"
      d.cmd = ["/srv/helloworld.py"]
      d.ports = ["80:80"]
    end
  end

end
Vagrant.configure("2") do |config|
  # Disable vagrant folder sync, because of
  # https://github.com/mitchellh/vagrant/issues/5143
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Override docker host with our own
  config.vm.provider "docker" do |d|
    d.vagrant_vagrantfile = "docker-consul-host/Vagrantfile"
  end

  config.vm.define "consul" do |consul|
    consul.vm.provider "docker" do |d|
      d.image = "cargonauts/consul-web"
      d.cmd = ["/consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /opt/config/ -client 0.0.0.0 -ui-dir /web-ui/dist"]
      d.ports = ['53:53/udp', '8500:8500']
    end
  end

  config.vm.define "helloworld" do |helloworld|
    helloworld.vm.provider "docker" do |d|
      d.image = "cargonauts/helloworld-python"
      d.cmd = ["/srv/helloworld.py"]
      d.ports = ["80:80"]
    end
  end

end
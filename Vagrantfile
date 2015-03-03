Vagrant.configure("2") do |config|
  # config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.define "consul" do |consul|
    consul.vm.provider "docker" do |d|
      d.vagrant_vagrantfile = "docker-consul-host/Vagrantfile"
      d.build_dir = "consul"
      d.create_args = ['-d', '-p', '53:53/udp']
    end
  end

  config.vm.define "helloworld" do |helloworld|
    helloworld.vm.provider "docker" do |d|
      d.vagrant_vagrantfile = "docker-consul-host/Vagrantfile"
      d.build_dir = "helloworld"
      d.ports = ["12345:80"]
    end
  end

end
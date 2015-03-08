Vagrant.configure("2") do |config|
  # Disable vagrant folder sync, because of
  # https://github.com/mitchellh/vagrant/issues/5143
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Override docker host with our own
  config.vm.provider "docker" do |d|
    d.vagrant_vagrantfile = "docker-consul-host/Vagrantfile"
  end

  config.vm.define "helloworld1" do |helloworld1|
    helloworld1.vm.provider "docker" do |d|
      d.image = "cargonauts/helloworld-python"
      d.cmd = ["/srv/helloworld.py"]
      d.ports = ["80:80"]
    end
  end

end
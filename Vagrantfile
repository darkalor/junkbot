Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "deploy/bootstrap.sh"
  config.vm.provision :shell, path: "deploy/project.sh"
end

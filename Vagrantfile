proxy = ENV['https_proxy'] || ""

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure("2") do |config|

  config.ssh.username   = 'root' 
  config.ssh.password   = 'root' #default pass


# usar estas lineas despues de bloquear ssh con root y add la llave a la lista de keys permitidas con el user killer 
# y cambiar la llave privada de ~/ssh/id_rsa por la de .vagrant/machines/default/docker/
#  config.ssh.username   = 'killer'
#  config.ssh.keys_only = false
#  config.ssh.private_key_path= ["~/ssh/id_rsa"]
  
  config.vm.define "default"

  config.hostmanager.enabled           = true
  config.hostmanager.manage_guest      = true

  config.vm.provider "docker" do |d|
    d.build_dir       = "."
    d.has_ssh         = true
    d.remains_running = true
  end

  config.vm.hostname = "ansible"

  config.vm.network "forwarded_port", guest: 8080, host: 7000, host_ip: "127.0.0.1", auto_correct: true

  config.vm.provision :hostmanager

  config.vm.provision :ansible do |ansible|
    ansible.playbook      = "ansible/platform.yaml"
    ansible.become          = true
    ansible.compatibility_mode='2.0'
    ansible.extra_vars = {
      proxy_env: {
        http_proxy: "http://192.164.1.57:8080",
        https_proxy: "http://192.164.1.57:8080",
      }
    }
    ansible.groups= {
      "hitleap":["default"],
      "server":["default"],
    }
  end
end

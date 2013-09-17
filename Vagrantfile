Vagrant.configure('2') do |config|

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = 'chef/Berksfile'

  config.vm.define :scm do |scm|
    scm.vm.box = 'scc_sles11sp3'
    scm.vm.network :private_network, ip: '192.168.42.42'
    scm.vm.provider :virtualbox do |vb|
      vb.customize [:modifyvm, :id, '--cpus', 2]
      vb.customize [:modifyvm, :id, '--memory', 1024]
    end
    scm.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = ['scm_check', 'minitest-handler']
    end
  end

end

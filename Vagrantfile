Vagrant.configure('2') do |config|

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = 'chef/Berksfile'

  config.vm.define :scm do |scm|
    scm.vm.box = 'scc_sles11sp3_kvm'
    scm.vm.provider :libvirt do |domain|
      domain.memory = 1024
      domain.cpus = 2
      domain.nested = true
      domain.volume_cache = 'none'
    end
    scm.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = ['scm_check', 'minitest-handler']
    end
  end

end

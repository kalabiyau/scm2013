Veewee::Definition.declare({
  :os_type_id => 'OpenSUSE_64',
  :cpu_count => '1',
  :memory_size => '1024',
  :disk_size => '20480',
  :disk_format => 'VDI',
  :hostiocache => 'off',
  :iso_file => 'SLES-11-SP3-DVD-x86_64-GM-DVD1.iso',
  :iso_src => 'http://schnell.suse.de/SLE11/iso/SLES-11-SP3-DVD-x86_64-GM-DVD1.iso',
  :iso_md5 => '480b70d50cbb538382dc2b9325221e1b',
  :iso_download_timeout => '1000',
  :boot_wait => '10',
  :boot_cmd_sequence => [
     '<Esc><Enter>',
     'linux netdevice=eth0 netsetup=dhcp install=cd:/',
     ' lang=en_US autoyast=http://%IP%:8080/autoinst.xml',
     ' textmode=1',
     '<Enter>'
  ],
  :ssh_login_timeout => '10000',
  :ssh_user => 'vagrant',
  :ssh_password => 'vagrant',
  :ssh_key => '',
  :ssh_host_port => '7222',
  :ssh_guest_port => '22',
  :sudo_cmd => "echo '%p'|sudo -S sh '%f'",
  :shutdown_cmd => 'halt',
  :postinstall_files => ['postinstall.sh'],
  :postinstall_timeout => '10000'
})

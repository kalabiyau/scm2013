#
# postinstall.sh
#

date > /etc/vagrant_box_build_time
echo 'solver.allowVendorChange = true' >> /etc/zypp/zypp.conf
echo 'solver.onlyRequires = true' >> /etc/zypp/zypp.conf

zypper --non-interactive ar http://schnell.suse.de/SLE11/SLES-11-SP3-GM/x86_64/DVD1 sles
zypper --non-interactive ar http://update.suse.de/zypp/x86_64/update/SLE-SERVER/11-SP3 sles_updates
zypper --non-interactive ar http://dist.suse.de/install/SLP/SLE-11-SP3-SDK-LATEST/x86_64/DVD1 scc_sdk
zypper --non-interactive ar http://update.suse.de/zypp/x86_64/update/SLE-SDK/11-SP3 scc_sdk_updates
zypper --non-interactive ar http://download.suse.de/ibs/Devel:/SCC/SLE_11_SP3 devel_scc
zypper --non-interactive rl  \*

# remove zypper locks on removed packages to avoid later dependency problems
rm /etc/zypp/locks

zypper --no-gpg-checks --non-interactive in --oldpackage --from devel_scc rpm
zypper --no-gpg-checks --non-interactive in --from devel_scc ruby
zypper --no-gpg-checks --non-interactive in --from devel_scc ruby-devel
echo 'gem: --no-ri --no-rdoc' > /etc/gemrc

# install vagrant key
echo -e "\ninstall vagrant key ..."
mkdir -m 0700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate -O authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant.users /home/vagrant/.ssh

# update sudoers
echo -e "\nupdate sudoers ..."
echo -e "\n# added by veewee/postinstall.sh" >> /etc/sudoers
echo -e "vagrant ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers

# speed-up remote logins
echo -e "\nspeed-up remote logins ..."
echo -e "\n# added by veewee/postinstall.sh" >> /etc/ssh/sshd_config
echo -e "UseDNS no\n" >> /etc/ssh/sshd_config

# install chef
echo -e "\ninstall chef ..."
gem install chef -v '=11.6.0.hotfix.1' --no-ri --no-rdoc

zypper refresh

echo -e "\nall done.\n"
exit

require 'minitest/spec'

describe_recipe 'scm_check::default' do

  describe 'groups' do

    it 'will create admins group' do
      group('admins').must_exist
    end

  end

  describe 'users' do

    it 'will create wengel user' do
      user('wengel').must_exist
    end

    it 'will create kalabiyau user' do
      user('kalabiyau').must_exist
    end

  end

  describe 'files' do

    describe 'test_file' do

      it 'creates test file with proper security' do
        assert_file '/etc/test_me_please', 'root', 'root', '0600'
      end

      it 'creates test file with proper content' do
        assert_includes_content File.open('/etc/test_me_please'), 'this_should_be_here'
      end

    end

    describe '/etc/resolv.conf' do

      it 'creates resolv.conf with proper security' do
        assert_file '/etc/resolv.conf', 'root', 'root', '0644'
      end

      it 'creates resolv.conf with proper content' do
        assert_includes_content File.open('/etc/resolv.conf'), 'search suse.de'
      end

    end

  end

  describe 'software' do

    describe 'redis' do

      it 'installs redis server' do
        package('redis').must_be_installed
      end

      it 'creates proper config file' do
        assert_file '/etc/redis/default.conf', 'redis', 'redis', '0600'
      end

      it 'runs and enables redis server' do
        service('redis').must_be_running
        service('redis').must_be_enabled
      end

    end

  end

end

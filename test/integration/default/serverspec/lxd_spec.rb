require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('lxd') do
  it { should be_installed }
end

describe file('/usr/bin/lxd') do
  it { should be_file }
  it { should be_executable }
end

describe service('lxd'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end
describe service('lxd-bridge'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_enabled }
#  it { should be_running }
end

describe file('/var/lib/lxd/unix.socket') do
  it { should be_socket }
end


describe interface('lxdfan0') do
  it { should exist }
end

describe interface('lxdbr0') do
  it { should exist }
end
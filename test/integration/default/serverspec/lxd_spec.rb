require 'serverspec'

# Required by serverspec
set :backend, :exec

if (os[:family] == 'ubuntu' && os[:release] == '20.04')
  set snap_lxd = true
else
  set snap_lxd = false
end

describe package('lxd') do
  it { should be_installed }
end

describe file('/usr/bin/lxd') do
  it { should be_file }
  it { should be_executable }
end

describe service('lxd'), :if => os[:family] == 'ubuntu' and not snap_lxd do
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/lib/lxd/unix.socket'), :if => os[:family] == 'ubuntu' and not snap_lxd do
  it { should be_socket }
end

describe command('snap info'), :if => os[:family] == 'ubuntu' and snap_lxd do
  its(:stdout) { should match /lxd/ }
  its(:stderr) { should match /^$/ }
  its(:exit_status) { should eq 0 }
end

describe interface('lxdfan0') do
  it { should exist }
end

describe interface('lxdbr0') do
  it { should exist }
end

describe port(8443) do
  it { should be_listening.with('tcp') }
end

# FIXME: there is no ipv6 on travis
# describe port(8443) do
#   it { should be_listening.with('tcp6') }
# end

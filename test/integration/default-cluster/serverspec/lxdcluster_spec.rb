require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('lxc info') do
  its(:stdout) { should match /certificate_fingerprint/ }
  its(:stderr) { should match /^$/ }
  its(:exit_status) { should eq 0 }
end

describe command('lxc cluster list') do
  its(:stdout) { should match /ONLINE/ }
  its(:stdout) { should match /bin/ }
  its(:stderr) { should match /No such file or directory/ }
  its(:exit_status) { should eq 0 }
end

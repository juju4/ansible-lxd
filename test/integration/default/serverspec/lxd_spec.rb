require 'serverspec'

# Required by serverspec
set :backend, :exec

## FIXME! running test fails on travis/xenial: https://travis-ci.org/juju4/ansible-lxd/jobs/152119834
describe service('lxd') do  
  it { should be_enabled   }
  it { should be_running   }
end
describe service('lxd-bridge'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_enabled   }
  it { should be_running   }
end

describe file('/var/lib/lxd/unix.socket') do
  it { should be_socket }
end


require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('lxd') do  
  it { should be_enabled   }
  it { should be_running   }
end
describe service('lxd-bridge') do  
  it { should be_enabled   }
  it { should be_running   }
end

describe file('/var/lib/lxd/unix.socket') do
  it { should be_socket }
end


[![Actions Status - Master](https://github.com/juju4/ansible-lxd/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-lxd/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-lxd/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-lxd/actions?query=branch%3Adevel)

# LXD ansible role

Ansible role to install LXD only and do network configuration.
https://linuxcontainers.org/lxd/getting-started-cli/

Containers configuration or publishing is done in separated roles.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0
 * 2.2
 * 2.5

### Operating systems

Tested on Ubuntu 14.04, 16.04 and 18.04.
Initial support for RHEL/Centos7 through ngompa/snapcore-el7 copr.

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - juju4.lxd
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis test calling kitchen with lxd (for github), kitchen local with vagrant+virtualbox and also a Vagrantfile (test/vagrant).

Once you ensured all necessary roles are present, You can test with:
```
$ cd /path/to/roles/juju4.lxd
## lxd backend
$ kitchen verify
$ kitchen login
## vagrant+virtualbox backend
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.lxd/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues

* for network connectivity
check if http_proxy is set (usually from /etc/default/lxd-bridge proxy settings)
check iptables nat config for masquerading
```
# iptables -t nat -L
## if empty
# iptables -t nat -A POSTROUTING -s 10.x.y.0/24 -o eth0 -j MASQUERADE
```
* if you want to forward traffic external to host to one of the private lxc container
```
# iptables -t nat -A PREROUTING -i if_incoming -p tcp --dport port_incoming -j DNAT --to-destination container_ip:container_port
```

* role can be executed on centos/redhat system on containers as kernel is host's
but RHEL/CentOS 7 has kernel 3.10 which is ?not compatible with LXC.
* service command on centos7 stalling
```
$ /bin/systemctl start lxd
```

* Rhel/Centos8 disable as snap in lxd kitchen requires extra config
https://forum.proxmox.com/threads/ubuntu-snaps-inside-lxc-container-on-proxmox.36463/#post-230060

## License

BSD 2-clause


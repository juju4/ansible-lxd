[![Build Status](https://travis-ci.org/juju4/ansible-lxd.svg?branch=master)](https://travis-ci.org/juju4/ansible-lxd)
# LXD ansible role

Ansible role to setup LXD, its bridge, pre-copy images and eventually pre-configure some.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0

### Operating systems

Tested on Ubuntu Trusty and Xenial

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - lxd
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis test calling kitchen with lxd (for github), kitchen local with vagrant+virtualbox and also a Vagrantfile (test/vagrant).

Once you ensured all necessary roles are present, You can test with:
```
$ cd /path/to/roles/lxd
## lxd backend
$ kitchen verify
$ kitchen login
## vagrant+virtualbox backend
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/lxd/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues


## License

BSD 2-clause


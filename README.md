marklee77.openvpn-server
========================

[![Build Status](https://travis-ci.org/marklee77/ansible-role-openvpn-server.svg?branch=master)](https://travis-ci.org/marklee77/ansible-role-openvpn-server)

The purpose of this role is to deploy openvpn-server onto Ubuntu. There is also an
support for an experimental "dockerized" deployment. This dockerized deployment
copies the role to the target machine and uses the original ansible-based
functionality to build a docker image, and then uses recent ansible features to
manage the running service. The dockerized deployment can theoretically deploy
to any Linux platform with a running docker install and the docker-py python
client library installed.

Travis status above refers only to the non-dockerized deployment, as docker does 
not (easily) run on travis.

Role Variables
--------------

- openvpn-server_repository_mirror: http://mirrors.coreix.net/openvpn-server by default.
- openvpn-server_version: 10.0
- openvpn-server_mysql_root_password: random value
- openvpn-server_bind_address: 127.0.0.1
- openvpn-server_port: 3306

The variables below only affect the dockerized deployment:

- openvpn-server_dockerized_deployment: false
- openvpn-server_docker_username: default
- openvpn-server_docker_imagename: openvpn-server
- openvpn-server_docker_containername: openvpn-server

Example Playbook
-------------------------

    - hosts: all
      sudo: True
      roles:
        - marklee77.openvpn-server

License
-------

GPLv2

Author Information
------------------

http://stillwell.me

Known Issues
------------

- the dockerized deployment still requires sudo access, even though a member of 
  the docker group should be able to build and deploy containers without sudo.

Todo
----

- option to map unix socket to local or to *not* map ip address...
- user .my.cnf configured to connect to openvpn-server_bind_address:openvpn-server_port if 
  bound and no socket?
- automatic rebuild on changes that might affect dockerfile?

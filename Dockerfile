FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/ansible/openvpn-server
WORKDIR /var/cache/ansible/openvpn-server

RUN ansible-playbook -i inventories/local.ini provisioning/install.yml

VOLUME [ "/etc/openvpn", "/var/log/openvpn" ]

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf" ]

#EXPOSE 3306

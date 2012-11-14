#!/bin/bash
# Creation of the georchestra directory (see template geOrchestra perfil)

# Verify that ldapadd esta instalado
if [[ ! -e $(which ldapadd) ]]; then
	aptitude install ldap-utils
fi

# Verify if slapd server is running
if [[ ! $(service slapd status) ]]; then
	aptitude install sldapd
fi

# remove posible backups
rm -rf /var/backups/*.ldapdb

# Configure the slapd server
dpkg-reconfigure slapd

# Create the directory
ldapadd -x -D cn=admin,dc=georchestra,dc=org -w secret -f georchestra.ldif

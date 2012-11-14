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

# Create the LDAP database
# The administrator is: cn=admin,dc=georchestra,dc=org
ldapadd -Y EXTERNAL -H ldapi:/// -f LDAP/georchestra-bootstrap.ldif

# Create the directory
ldapadd -D"cn=admin,dc=georchestra,dc=org" -w"secret" -f LDAP/georchestra-root.ldif

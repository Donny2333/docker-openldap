docker rm -f openldap
docker run ^
-d ^
-p 389:389 ^
-p 636:636 ^
-v %cd%/ldap:/usr/local/ldap ^
-v %cd%/data/openldap/ldap:/var/lib/ldap ^
-v %cd%/data/openldap/slapd.d:/etc/ldap/slapd.d ^
--env LDAP_ORGANISATION="Manager" ^
--env LDAP_DOMAIN="example.com" ^
--env LDAP_ADMIN_PASSWORD="123456" ^
--name openldap ^
--hostname openldap-host ^
--net my-network --ip 172.20.1.10 ^
osixia/openldap:stable-amd64

@REM Login DN: cn=admin,dc=example,dc=com
@REM Password: 123456

docker rm -f phpldapadmin
docker run ^
-p 10001:80 ^
--privileged ^
--name phpldapadmin ^
--net my-network --ip 172.20.1.11 ^
--link openldap:openldap ^
--env PHPLDAPADMIN_HTTPS=false ^
--env PHPLDAPADMIN_LDAP_HOSTS=openldap ^
-d osixia/phpldapadmin:stable-amd64

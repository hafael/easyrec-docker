CREATE DATABASE easyrec;
GRANT index, create, select, insert, update, drop, delete, alter, lock tables on easyrec.* TO 'VAR_EASYREC_USER'@'%' identified by 'VAR_EASYREC_PASSWORD';
FLUSH PRIVILEGES;
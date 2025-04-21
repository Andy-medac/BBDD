alter session set "_ORACLE_SCRIPT" = true;

create user concesionario IDENTIFIED BY "Med@c"
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 100M ON USERS;
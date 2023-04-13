--�ý��� ���� �ο�
--WITH ADMIN OPTION�� �־� �ο��غ���
-- system���� �����ؼ� �Ʒ� ������ �����Ѵ�
GRANT CREATE USER, ALTER USER,
DROP USER TO MYSTAR
WITH ADMIN OPTION;

--mystar�� �����ؼ� �ٸ� user�� �����غ���.
conn mystar/mystar
show user

create user storm
identified by storm;

-- storm�� �ٸ� user�� ������ ������ ���´�

-- mystar�� storm user�� ����� �����غ���
alter user storm
identified by tiger;

drop user storm;

-- system���� �����ؼ� mystar�� ���� ��
-- alter user, drop user������ ȸ���غ���
conn system/Abcd1234
show user

-- REVOKE ����|�� FROM USER|��

REVOKE ALTER USER, DROP USER FROM MYSTAR;

-- MYSTAR�� ���� �ؼ� 
-- storm�� �ٽ� �����غ���
conn mystar/mystar
create user storm
identified by storm;

-- storm�� ����� tiger�� �����غ���
alter user storm
identified by tiger;
-- ORA-01031: insufficient privileges ���� �߻�
---------------------------------------------
 �ó�����

 1. DBA�� STORM���� WITH ADMIN OPTION�� ����Ͽ� 
 CREATE TABLE, CREATE SESSION �ý��� ������ �ο� �մϴ�. 

grant create table, create session
to storm with admin option;

2.  STORM���� �����ؼ�
STORM�� ���̺��� ���� �մϴ�. 
NOTE���̺� ����
NO NUMBER
MSG VARCHAR2(30)

create table note(
no number,
msg varchar2(30)
);
==>  no privileges on tablespace 'SYSTEM' ���� �߻�

conn system/Abcd1234

alter user storm quota 2M on system;

conn storm/storm
create table note(
no number,
msg varchar2(30)
);

2_2. SYSTEM���� �����ؼ� MILLER USER�� �����Ѵ�.
	MILLER���� CREATE SESSION ������ �ο��Ѵ�
conn system/Abcd1234

create user miller
identified by miller;

grant create session to miller;

conn storm/storm


3. STORM�� CREATE TABLE �ý��� ������ 
   MILLER���� �ο� �մϴ�. 
grant create table to miller;

conn system/Abcd1234
alter user miller quota unlimited on system;

4. MILLER�� ���̺��� ���� �մϴ�. 
conn miller/miller
create table note(
no number);
--------------------------------------
5. DBA�� STORM���� �ο��� 
   CREATE TABLE �ý��� ������ ��� �մϴ�.
conn system/Abcd1234   
   revoke create table from storm; 

conn storm/storm
create table test(no number);
=>insufficient privileges ���� �߻�

6. miller�� create table ������ ��� �Ǿ�����?
conn miller/miller
create table test(no number);

���: with admin option���� �־��� ������ storm���� ��Ҹ� �ص�
miller�� create table ������ ��ҵ��� �ʴ´�

------------------------------------------------------------
alter user storm quota 2M on users
---------------------------------------------------------
# ��ü ����
conn scott/tiger
grant select,insert on emp
to storm
with grant option;

conn storm/storm
select ename,job
from scott.emp;
insert into scott.emp(empno,ename,job)
values(8100,'JAMES','MANAGER');
COMMIT;
--------------------------------
STORM�� SCOTT.EMP ���̺��� SELECT�ϴ� ������ MILLER���� �ο��� �غ���.

grant select on scott.emp to miller;
CONN miller/miller
select ename, job from scott.emp;
--------------------------------
SCOTT�� STORM���� �ο��ߴ� SELECT,INSERT ON EMP�� ���� ������ ȸ���Ѵ�
conn scott/tiger

REVOKE SELECT,INSERT ON EMP FROM STORM;

conn storm/storm
select ename from scott.emp;
=> error�߻� table or view does not exist
--------------------------------
�׷��� miller�� ��� �Ǿ�����?
conn miller/miller
select ename from scott.emp;
=> error�߻� table or view does not exist
------------------------------------------
���: WITH GRANT OPTION�� ����Ͽ� ��ü ���� ���
  WITH GRANT OPTION�� ����Ͽ� �ο��� ��ü ������ ����ϸ� ��� �۾��� 
  ���������� ���� �˴ϴ�. 

# role ���� �� �ο�
[1] �� ����
create role ���̸�;

[2] �ѿ� ���� �ο�
grant ����1, ����2 to ���̸�;

[3] ���� ����ڿ��� �ο�
grant ���̸� to ����ڸ�;

conn system/Abcd1234;

create role manager;

manager�ѿ� create session, create table, create view, create synonym
������ �ο��ϼ���

GRANT create session, create table,
create view, create synonym TO manager;


������ �������� ��ȸ
 - DBA_ROLES
 - DBA_SYS_PRIVS
 
 SELECT * FROM DBA_ROLES;
 
 SELECT * FROM DBA_SYS_PRIVS
 WHERE GRANTEE='MANAGER';
 
 SELECT * FROM DBA_SYS_PRIVS
 WHERE GRANTEE='CONNECT';
 
  SELECT * FROM DBA_SYS_PRIVS
 WHERE GRANTEE='RESOURCE';
 
conn system/Abcd1234
- MANAGER���� MILLER���� �ο��غ�����
grant manager to miller;

create view miller_view
as
select * from note;

=> �䰡 �� ������

select * from dba_sys_privs
where grantee=upper('dba');

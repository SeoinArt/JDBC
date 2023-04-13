�ý��� ����(System Privileges) 
: ����Ŭ���� ����(Privilege)�� Ư�� Ÿ���� SQL���� �����ϰų� �����ͺ��̽��� ������ ���̽� ��ü�� ������ �� �ִ� �Ǹ��Դϴ�.

SYSTEM PRIVILEGES

 - �ý��� ������ ����ڰ� �����ͺ��̽����� Ư�� �۾��� ���� �� �� �ֵ��� �մϴ�
 - �� 126���� �ý��� ������ ������ �� ���� ��� �����ϰ� �ֽ��ϴ�. 
 - ������ ANY Ű����� ����ڰ� ��� ��Ű������ ������ ������ �ǹ� �մϴ�.
 - GRANT ����� ����� �Ǵ� Role�� ���ؼ� ������ �ο� �մϴ�. 
 - REVOKE ����� ������ ���� �մϴ�. 


��ǥ���� �ý��� ����     
  -  CREATE SESSION : ������ ���̽��� ������ �� �ִ� ����
  -  CREATE ROLE : ����Ŭ �����ͺ��̽� ������ ������ �� �ִ� ����
  -  CREATE VIEW : ���� ���� ����
  -  ALTER USER : ������ ������� ���Ǹ� ������ �� �ִ� ����
  -  DROP USER : ������ ����ڸ� ������Ű�� ���ѽý��� ������ ���� ���
 

�ý��� ���� �ο� ����(Syntax)

GRANT [system_privilege| role] 
TO [user|role|PUBLIC]
[WITH ADMIN OPTION]

 - system_privilege : �ο��� �ý��� ������ �̸�
 - role : �ο��� �����ͺ��̽� ������ �̸�
 - user, role : �ο��� ����� �̸��� �ٸ� ������ ���̽� ���� �̸�
 - PUBLIC : �ý��� ����, �Ǵ� �����ͺ��̽� ������ ��� ����ڿ��� �ο��� �� �ֽ��ϴ�.
 - WITH ADMIN OPTION 
     : ������ �ο� ���� ����ڵ� �ο� ���� ������ �ٸ� ����� �Ǵ� ���ҷ� �ο��� �� �ְ� �Ǹ�, 
	   ���� ����ڰ� WITH ADMIN OPTION�� ���� ������ �ο� �޴´ٸ� �ο��� ������ �� ����ڿ� ���� ���� �Ǵ� ���� �� �� �ֽ��ϴ�. 

 �ý��� ���� �ο� ����
 
 CONN SYSTEM/Abcd1234

SQL>GRANT CREATE USER, ALTER USER, DROP USER TO mystar
        WITH  ADMIN  OPTION.

 ������ �ο��Ǿ����ϴ�.

*���� : scott ����ڿ��� ����ڸ� ����, ����, ���� �� �� �ִ� ������ �ο��ϰ�,
         scott ����ڵ� �ٸ� ����ڿ��� �� ������ �ο� �� �� �ֽ��ϴ�.
 
 

�ý��� ������ ��Ż 

 
����(Syntax)

REVOKE [system_privilege| role] FROM [user|role|PUBLIC] 

�ý��� ���� öȸ ����
 

SQL>REVOKE CREATE USER, ALTER USER, DROP USER 
        FROM scott
        

 ������ ȸ���Ǿ����ϴ�.

*���� : scott ����ڿ��� �ο��� ����, ����, ���� ������ ȸ���մϴ�,
           
 

WITH ADMIN OPTION�� ����Ͽ� �ý��� ���� ���
 

 WITH ADMIN OPTION�� ����Ͽ� �ý��� ������ �ο��߾ 
 �ý��� ������ ��� �� ���� ���������� ��� ���� �ʽ��ϴ�. 


 �ó�����

�ó�����

 1. DBA�� STORM���� WITH ADMIN OPTION�� ����Ͽ� 
 CREATE TABLE, CREATE SESSION �ý��� ������ �ο� �մϴ�. 

2.  STORM���� �����ؼ�
STORM�� ���̺��� ���� �մϴ�. 
NOTE���̺� ����
NO NUMBER
MSG VARCHAR2(30)

2_2. SYSTEM���� �����ؼ� MILLER USER�� �����Ѵ�.
	MILLER���� CREATE SESSION ������ �ο��Ѵ�

3. STORM�� CREATE TABLE �ý��� ������ 
   MILLER���� �ο� �մϴ�. 

4. MILLER�� ���̺��� ���� �մϴ�. 

5. DBA�� STORM���� �ο��� 
   CREATE TABLE �ý��� ������ ��� �մϴ�.
   revoke create table from storm container=all
  
alter user storm default tablespace users quota unlimited on users;
alter user storm quota 2M on users
  

���̺� �����̽� ���� ����
http://nowmir00.blog.me/90086830713
 ���
C
 - STORM�� ���̺��� ������ ���������� �� ���̺��� ������ �� �ִ� ������ �����ϴ�. 

 - SCOTT�� ������ ���̺�� ���ο� ���̺��� ���� �� �� �ִ� CREATE TABLE������ ������ �ֽ� 
 �ϴ�

////////////////////////////
�� Object Privileges(��ü ����)
   ��ü ������ ������ �����ϰ� �ִ� Ư���� ��ü�� �ٸ� ����ڵ��� 
   ������ �ϰų� ���� �� �� �ְ� �ϱ� ���ؼ� ������ �մϴ�. 

  - ���̺��̳� ��, ������, ���ν���, �Լ�, �Ǵ� ��Ű�� �� ������ 
    �� ������Ʈ�� Ư���� �۾��� ���� �� �� �ְ� �մϴ�. 
  
  - Object �����ڴ� �ٸ� ����ڿ��� Ư�� Object Privileges�� �ο� �� �� �ֽ��ϴ�. 
  - PUBLIC���� ������ �ο��ϸ� ȸ���� ���� PUBLIC���� �ؾ� �մϴ�. 
  - Object Privileges�� Object Type�� ���� �ٸ��ϴ�. 
  - �⺻������ ������ ������Ʈ�� ���� ��� ������ �ڵ������� ȹ��˴ϴ�
  - WITH GRANT OPTION �ɼ��� '��' �� ������ �ο��� ���� ����� �� �����ϴ�


 * Object�� ���� Privileges
   ----------------------------------------------------
��ü����	 ���̺�	 ��	 Sequence	 Procedure
   ---------------------------------------------------- 
  ALTER		  ��	              ��
  ----------------------------------------------------
 
  DELETE     ��		 ��
   ----------------------------------------------------
   
  EXECUTE							 ��
   ----------------------------------------------------
 
  INDEX	 ��  
   ----------------------------------------------------  
  INSERT	 ��		 ��
  ----------------------------------------------------
  REFERENCES ��
   ----------------------------------------------------
  SELECT	 ��		 ��	   ��
   ----------------------------------------------------  
  UPDATE	 ��		 ��
 ----------------------------------------------------  

  ���� ǥ���� �� ���ʿ� �ִ� ALTER, DELETE, EXECUTE.. 
  ����� object_privilege���� ���� �ǰ�, 
�� ���ٿ� �ִ� ���̺�, ��, ������, ���ν��� ����� 
ON ������ �ִ� object�� �Է��ϸ� ��. 

-����(Syntax)
  GRANT object_privilege [column] ON object
  TO {user[,user] | role |PUBLIC]
  [WITH GRANT OPTION]

 - object_privilege : �ο��� ��ü ������ �̸�
 - object : ��ü��
 - user, role : �ο��� ����� �̸��� �ٸ� ������ ���̽� ���� �̸�
 - PUBLIC : ������ ����, �Ǵ� �����ͺ��̽� ������ ��� ����ڿ��� �ο��� �� �ֽ��ϴ�.
 - WITH GRANT OPTION : ������ �ο� ���� ����ڵ� �ο� ���� ������ �ٸ� ����� �Ǵ� ���ҷ� 
                      �ο��� �� �ְ� �˴ϴ�. Object ���� �ο� ����

 
������ ���� �ο� ����
SQL>GRANT SELECT, INSERT
        ON emp
        TO scott
        WITH  GRANT  OPTION.

 ������ �ο��Ǿ����ϴ�.

*���� : scott ����ڿ��� emp���̺��� SELECT, INSERT�� �� �ִ� ������ �ο��߽��ϴ�.
          scott ����ڵ� �ٸ� ����ڿ��� �� ������ �ο� �� �� �ֽ��ϴ�.
 

Object ������ ��Ż 

 - ��ü ������ öȸ�� �� ������ �ο��� �ο��ڸ��� �����Ҽ� �ֽ��ϴ�. 
 - CASCADE CONSTRAINTS : �� ��ɾ��� ������� REFERENCES��ü ���ѿ��� ���� 
               ���� ���Ἲ ������ ���� ���� �� �� �ֽ��ϴ�. 

 - ���� ��ü ������ �ο��� ������� ��ü ������ öȸ�ϸ�, ������ 
   �ο����� ����ڰ� �ο��� ��ü ���� ���� ���� öȸ�Ǵ� ����öȸ�� �߻��մϴ�.
   WITH GRANT OPTION
 
������ ���� öȸ ����
 
SQL>REVOKE SELECT, INSERT
         ON emp
         FROM scott

*���� : scott ����ڿ��Ժο��� emp���̺� ���� SELECT, INSERT������ ȸ�� �˴ϴ�..
         ���� scott����ڰ� �ٸ� ����ڿ��� SELECT, INSERT������ �ο�������..
         �� ���ѵ鵵 ���� öȸ�� �˴ϴ�.

WITH GRANT OPTION�� ����Ͽ� ��ü ���� ���
  WITH GRANT OPTION�� ����Ͽ� �ο��� ��ü ������ ����ϸ� ��� �۾��� 
  ���������� ���� �˴ϴ�. 

 �ó�����
 1. SCOTT�� KING���� WITH GRANT OPTION�� ����Ͽ� DEPT���̺��� 
    SELECT ������ �ο� �մϴ�. 
    
2. SYSTEM���� �����ؼ� USER�� ���� �����ϵ� 
   USER���� TEST�� �ּ���.
    TEST���� CONNECT, RESOURCE ���� �ο��ϼ���

3. KING�� DEPT���̺��� SELECT������ TEST���� �ο� �մϴ�. 

4. TEST�� �����ؼ� SCOTT�� DEPT���̺��� SELECT�غ���

5. SCOTT�� KING���� �ο��� DEPT���̺��� 
   SELECT ������ ��� �մϴ�. 
   
6. TEST�� �����ؼ� �ٽ� SCOTT�� DEPT���̺��� SELECT�غ���

  

 ���

 - SCOTTt�� KING���� �ο��� DEPT���̺� ���� SELECT ������ ����ϸ� 
   KING�� �ο��� TEST������ DEPT���̺��� SELECT�� �� �ִ� ���ѵ� 
   �ڵ����� ��Ұ� �˴ϴ�. 
  

 //////////////////////////////////////////////////////////

 ROLE �̶� ����ڿ��� �㰡�� �� �ִ� ���ѵ��� ���� �̶�� �� �� �ֽ��ϴ�. 

  - ROLE�� �̿��ϸ� ���� �ο��� ȸ���� ���� �� �� �ֽ��ϴ�. 
  - ROLE�� Create Role������ ���� User�� ���ؼ� ���� �˴ϴ�.�� 
  - �� ����ڰ� �������� ROLL�� ACCESS�� �� �ְ�,  ���� ����ڿ��� ���� ROLE�� �ο��� �� 
    �ֽ��ϴ�. 
  - �ý��� ������ �ο��ϰ�, ����� ���� ������ ����� ����Ͽ� ����ڿ��� �ο��ϰ�, ��� �մϴ�. 
  - ����ڴ� ROLE�� ROLE�� �ο��� �� �ֽ��ϴ�. 
  - ����Ŭ �����ͺ��̽��� ��ġ�ϸ� �⺻������ CONNECT, RESOURCE, DBA ROLE�� ����  
    �˴ϴ�.
   �Ʒ��� �׸�ó�� DBA�� �����鿡�� ������ �ο��� �� ������ ���� �ϳ��ϳ����� ������ �Ѵٸ� ���� ������ �� �Դϴ�. 
   DBA�� USER�� ���ҿ� �µ��� Role�� �����Ͽ��� Role�� �������� ������ �Ѵٸ� ���� ȿ������ �� �������� ������ 
   ���� �� �� �ֽ��ϴ�. 

ROLE�� ����

����
ROLE��  �ο� ����
 �� ROLE�� ����  :  CREATE ROLE manager
 �� ROLE�� ���� �ο� : GRANT create session, create table TO manager
 �� ROLE�� ����� �Ǵ� ROLE���� �ο� : GRANT manager TO scott, test;
 
 
-- role�� ���� �մϴ�. 
SQL> CREATE ROLE manager

-- role�� ������ �ο� �մϴ�. 
SQL>GRANT create session, create table TO manager

-- ������ �ο��� role�� user�� role�� �ο� �մϴ�. 
SQL>GRANT manager TO scott, test; 
 
 

 
SQL>SELECT * FROM DBA_ROLES;

ROLE                             PASSWORD
----------------------    -----------
CONNECT                              NO
RESOURCE                            NO
DBA                                       NO
SELECT_CATALOG_ROLE        NO
EXECUTE_CATALOG_ROLE      NO
DELETE_CATALOG_ROLE         NO
EXP_FULL_DATABASE             NO
IMP_FULL_DATABASE              NO
....

�� �ܿ��� ���� ROLE�� �����մϴ�. 
�� �߿��� ���� ���� ����ϴ� 3������ ���� �ϰڽ��ϴ�. 

 
�� CONNECT
 
- ����Ŭ�� ���� �� �� �ִ� ���� ���� �� ���̺��� �����ϰų� 
  ��ȸ �� �� �ִ�  ���� �Ϲ����� ���ѵ�� �̷���� �ֽ��ϴ�. 

- CONNECT Role�� ������ ������ �����ϰ��� Oracle�� ���� �� ���� �����ϴ�. 

- �Ʒ��� ��ɾ�� CONNECT Role�� � �������� �̷���� �ִ��� Ȯ�� �� �� �ֽ��ϴ�.


 SQL>SELECT grantee, privilege 
        FROM DBA_SYS_PRIVS
        WHERE grantee = ��CONNECT��;

GRANTEE     PRIVILEGE
----------- ---------------------
CONNECT     ALTER SESSION
CONNECT     CREATE CLUSTER
CONNECT     CREATE DATABASE LINK
CONNECT     CREATE SEQUENCE
CONNECT     CREATE SESSION
CONNECT     CREATE SYNONYM
CONNECT     CREATE TABLE
CONNECT     CREATE VIEW

 
�� RESOURCE
 - Store Procedure�� Trigger�� ���� PL/SQL�� ����� �� �ִ� 
   ���� ��� �̷���� �ֽ��ϴ�. 
 - PL/SQL�� ����Ϸ��� RESOURCE Role�� �ο��ؾ� �մϴ�. 
 - ������ �����ϸ� �Ϲ������� CONNECT, RESOURCE���� �ο� �մϴ�. 

SQL>SELECT grantee, privilege 
        FROM DBA_SYS_PRIVS
        WHERE grantee = ��RESOURCE��;
 
�� DBA
 - ��� �ý��� ������ �ο��� Role�Դϴ�.
 - DBA Role�� �����ͺ��̽� �����ڿ��Ը� �ο��ؾ� �մϴ�.  
  ================================================ 
    * �ڷ���ó: �����ͺ��̽� �������� Ŀ�´�Ƽ oracleclub.com 
    
    
    
    
    
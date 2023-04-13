--시스템 권한 부여
--WITH ADMIN OPTION을 주어 부여해보자
-- system으로 접속해서 아래 문장을 실행한다
GRANT CREATE USER, ALTER USER,
DROP USER TO MYSTAR
WITH ADMIN OPTION;

--mystar로 접속해서 다른 user를 생성해보자.
conn mystar/mystar
show user

create user storm
identified by storm;

-- storm도 다른 user를 생성할 권한을 갖는다

-- mystar가 storm user의 비번을 변경해보자
alter user storm
identified by tiger;

drop user storm;

-- system으로 접속해서 mystar의 권한 중
-- alter user, drop user권한을 회수해보자
conn system/Abcd1234
show user

-- REVOKE 권한|롤 FROM USER|롤

REVOKE ALTER USER, DROP USER FROM MYSTAR;

-- MYSTAR로 접속 해서 
-- storm을 다시 생성해보자
conn mystar/mystar
create user storm
identified by storm;

-- storm의 비번을 tiger로 변경해보자
alter user storm
identified by tiger;
-- ORA-01031: insufficient privileges 에러 발생
---------------------------------------------
 시나리오

 1. DBA가 STORM에게 WITH ADMIN OPTION을 사용하여 
 CREATE TABLE, CREATE SESSION 시스템 권한을 부여 합니다. 

grant create table, create session
to storm with admin option;

2.  STORM으로 접속해서
STORM이 테이블을 생성 합니다. 
NOTE테이블 생성
NO NUMBER
MSG VARCHAR2(30)

create table note(
no number,
msg varchar2(30)
);
==>  no privileges on tablespace 'SYSTEM' 에러 발생

conn system/Abcd1234

alter user storm quota 2M on system;

conn storm/storm
create table note(
no number,
msg varchar2(30)
);

2_2. SYSTEM으로 접속해서 MILLER USER를 생성한다.
	MILLER에게 CREATE SESSION 권한을 부여한다
conn system/Abcd1234

create user miller
identified by miller;

grant create session to miller;

conn storm/storm


3. STORM이 CREATE TABLE 시스템 권한을 
   MILLER에게 부여 합니다. 
grant create table to miller;

conn system/Abcd1234
alter user miller quota unlimited on system;

4. MILLER가 테이블을 생성 합니다. 
conn miller/miller
create table note(
no number);
--------------------------------------
5. DBA가 STORM에게 부여한 
   CREATE TABLE 시스템 권한을 취소 합니다.
conn system/Abcd1234   
   revoke create table from storm; 

conn storm/storm
create table test(no number);
=>insufficient privileges 에러 발생

6. miller의 create table 권한은 어떻게 되었을까?
conn miller/miller
create table test(no number);

결론: with admin option으로 주었던 권한을 storm에게 취소를 해도
miller의 create table 권한은 취소되지 않는다

------------------------------------------------------------
alter user storm quota 2M on users
---------------------------------------------------------
# 객체 권한
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
STORM이 SCOTT.EMP 테이블을 SELECT하는 권한을 MILLER에게 부여를 해본다.

grant select on scott.emp to miller;
CONN miller/miller
select ename, job from scott.emp;
--------------------------------
SCOTT이 STORM에게 부여했던 SELECT,INSERT ON EMP에 대한 권한을 회수한다
conn scott/tiger

REVOKE SELECT,INSERT ON EMP FROM STORM;

conn storm/storm
select ename from scott.emp;
=> error발생 table or view does not exist
--------------------------------
그러면 miller는 어떻게 되었을까?
conn miller/miller
select ename from scott.emp;
=> error발생 table or view does not exist
------------------------------------------
결론: WITH GRANT OPTION을 사용하여 객체 권한 취소
  WITH GRANT OPTION을 사용하여 부여한 객체 권한을 취소하면 취소 작업이 
  연쇄적으로 수행 됩니다. 

# role 생성 및 부여
[1] 롤 생성
create role 롤이름;

[2] 롤에 권한 부여
grant 권한1, 권한2 to 롤이름;

[3] 롤을 사용자에게 부여
grant 롤이름 to 사용자명;

conn system/Abcd1234;

create role manager;

manager롤에 create session, create table, create view, create synonym
권한을 부여하세요

GRANT create session, create table,
create view, create synonym TO manager;


데이터 사전에서 조회
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
- MANAGER롤을 MILLER에게 부여해보세요
grant manager to miller;

create view miller_view
as
select * from note;

=> 뷰가 잘 생성됨

select * from dba_sys_privs
where grantee=upper('dba');

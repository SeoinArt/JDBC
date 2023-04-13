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
   revoke create table from storm container=all
  
alter user storm default tablespace users quota unlimited on users;
alter user storm quota 2M on users



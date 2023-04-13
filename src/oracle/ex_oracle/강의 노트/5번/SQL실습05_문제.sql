시스템 권한(System Privileges) 
: 오라클에서 권한(Privilege)은 특정 타입의 SQL문을 실행하거나 데이터베이스나 데이터 베이스 객체에 접근할 수 있는 권리입니다.

SYSTEM PRIVILEGES

 - 시스템 권한은 사용자가 데이터베이스에서 특정 작업을 수행 할 수 있도록 합니다
 - 약 126개의 시스템 권한이 있으며 그 수는 계속 증가하고 있습니다. 
 - 권한의 ANY 키워드는 사용자가 모든 스키마에서 권한을 가짐을 의미 합니다.
 - GRANT 명령은 사용자 또는 Role에 대해서 권한을 부여 합니다. 
 - REVOKE 명령은 권한을 삭제 합니다. 


대표적인 시스템 권한     
  -  CREATE SESSION : 데이터 베이스를 연결할 수 있는 권한
  -  CREATE ROLE : 오라클 데이터베이스 역할을 생성할 수 있는 권한
  -  CREATE VIEW : 뷰의 생성 권한
  -  ALTER USER : 생성한 사용자의 정의를 변경할 수 있는 권한
  -  DROP USER : 생성한 사용자를 삭제시키는 권한시스템 권한의 종류 몇가지
 

시스템 권한 부여 문법(Syntax)

GRANT [system_privilege| role] 
TO [user|role|PUBLIC]
[WITH ADMIN OPTION]

 - system_privilege : 부여할 시스템 권한의 이름
 - role : 부여할 데이터베이스 역할의 이름
 - user, role : 부여할 사용자 이름과 다른 데이터 베이스 역할 이름
 - PUBLIC : 시스템 권한, 또는 데이터베이스 역할을 모든 사용자에게 부여할 수 있습니다.
 - WITH ADMIN OPTION 
     : 권한을 부여 받은 사용자도 부여 받은 권한을 다른 사용자 또는 역할로 부여할 수 있게 되며, 
	   만약 사용자가 WITH ADMIN OPTION과 같이 역할을 부여 받는다면 부여된 역할은 그 사용자에 의해 변경 또는 삭제 될 수 있습니다. 

 시스템 권한 부여 예제
 
 CONN SYSTEM/Abcd1234

SQL>GRANT CREATE USER, ALTER USER, DROP USER TO mystar
        WITH  ADMIN  OPTION.

 권한이 부여되었습니다.

*설명 : scott 사용자에게 사용자를 생성, 수정, 삭제 할 수 있는 권한을 부여하고,
         scott 사용자도 다른 사용자에게 그 권한을 부여 할 수 있습니다.
 
 

시스템 권한의 박탈 

 
문법(Syntax)

REVOKE [system_privilege| role] FROM [user|role|PUBLIC] 

시스템 권한 철회 예제
 

SQL>REVOKE CREATE USER, ALTER USER, DROP USER 
        FROM scott
        

 권한이 회수되었습니다.

*설명 : scott 사용자에게 부여한 생성, 수정, 삭제 권한을 회수합니다,
           
 

WITH ADMIN OPTION을 사용하여 시스템 권한 취소
 

 WITH ADMIN OPTION을 사용하여 시스템 권한을 부여했어도 
 시스템 권한을 취소 할 때는 연쇄적으로 취소 되지 않습니다. 


 시나리오

시나리오

 1. DBA가 STORM에게 WITH ADMIN OPTION을 사용하여 
 CREATE TABLE, CREATE SESSION 시스템 권한을 부여 합니다. 

2.  STORM으로 접속해서
STORM이 테이블을 생성 합니다. 
NOTE테이블 생성
NO NUMBER
MSG VARCHAR2(30)

2_2. SYSTEM으로 접속해서 MILLER USER를 생성한다.
	MILLER에게 CREATE SESSION 권한을 부여한다

3. STORM이 CREATE TABLE 시스템 권한을 
   MILLER에게 부여 합니다. 

4. MILLER가 테이블을 생성 합니다. 

5. DBA가 STORM에게 부여한 
   CREATE TABLE 시스템 권한을 취소 합니다.
   revoke create table from storm container=all
  
alter user storm default tablespace users quota unlimited on users;
alter user storm quota 2M on users
  

테이블 스페이스 관련 참조
http://nowmir00.blog.me/90086830713
 결과
C
 - STORM의 테이블은 여전히 존재하지만 새 테이블을 생성할 수 있는 권한은 없습니다. 

 - SCOTT는 여전히 테이블과 새로운 테이블을 생성 할 수 있는 CREATE TABLE권한을 가지고 있습 
 니다

////////////////////////////
◈ Object Privileges(객체 권한)
   객체 권한은 유저가 소유하고 있는 특정한 객체를 다른 사용자들이 
   엑세스 하거나 조작 할 수 있게 하기 위해서 생성을 합니다. 

  - 테이블이나 뷰, 시퀀스, 프로시저, 함수, 또는 패키지 중 지정된 
    한 오브젝트에 특별한 작업을 수행 할 수 있게 합니다. 
  
  - Object 소유자는 다른 사용자에게 특정 Object Privileges를 부여 할 수 있습니다. 
  - PUBLIC으로 권한을 부여하면 회수할 때도 PUBLIC으로 해야 합니다. 
  - Object Privileges는 Object Type에 따라서 다릅니다. 
  - 기본적으로 소유한 오브젝트에 대한 모든 권한이 자동적으로 획득됩니다
  - WITH GRANT OPTION 옵션은 '롤' 에 권한을 부여할 때는 사용할 수 없습니다


 * Object에 따른 Privileges
   ----------------------------------------------------
객체권한	 테이블	 뷰	 Sequence	 Procedure
   ---------------------------------------------------- 
  ALTER		  ○	              ○
  ----------------------------------------------------
 
  DELETE     ○		 ○
   ----------------------------------------------------
   
  EXECUTE							 ○
   ----------------------------------------------------
 
  INDEX	 ○  
   ----------------------------------------------------  
  INSERT	 ○		 ○
  ----------------------------------------------------
  REFERENCES ○
   ----------------------------------------------------
  SELECT	 ○		 ○	   ○
   ----------------------------------------------------  
  UPDATE	 ○		 ○
 ----------------------------------------------------  

  위의 표에서 맨 왼쪽에 있는 ALTER, DELETE, EXECUTE.. 
  등등은 object_privilege란에 오면 되고, 
맨 윗줄에 있는 테이블, 뷰, 시퀀스, 프로시져 등등은 
ON 다음에 있는 object에 입력하면 됨. 

-구문(Syntax)
  GRANT object_privilege [column] ON object
  TO {user[,user] | role |PUBLIC]
  [WITH GRANT OPTION]

 - object_privilege : 부여할 객체 권한의 이름
 - object : 객체명
 - user, role : 부여할 사용자 이름과 다른 데이터 베이스 역할 이름
 - PUBLIC : 오브젝 권한, 또는 데이터베이스 역할을 모든 사용자에게 부여할 수 있습니다.
 - WITH GRANT OPTION : 권한을 부여 받은 사용자도 부여 받은 권한을 다른 사용자 또는 역할로 
                      부여할 수 있게 됩니다. Object 권한 부여 문법

 
오브젝 권한 부여 예제
SQL>GRANT SELECT, INSERT
        ON emp
        TO scott
        WITH  GRANT  OPTION.

 권한이 부여되었습니다.

*설명 : scott 사용자에게 emp테이블을 SELECT, INSERT할 수 있는 권한을 부여했습니다.
          scott 사용자도 다른 사용자에게 그 권한을 부여 할 수 있습니다.
 

Object 권한의 박탈 

 - 객체 권한의 철회는 그 권한을 부여한 부여자만이 수행할수 있습니다. 
 - CASCADE CONSTRAINTS : 이 명령어의 사용으로 REFERENCES객체 권한에서 사용된 
               참조 무결성 제한을 같이 삭제 할 수 있습니다. 

 - 으로 객체 권한을 부여한 사용자의 객체 권한을 철회하면, 권한을 
   부여받은 사용자가 부여한 객체 권한 또한 같이 철회되는 종속철회가 발생합니다.
   WITH GRANT OPTION
 
오브젝 권한 철회 예제
 
SQL>REVOKE SELECT, INSERT
         ON emp
         FROM scott

*설명 : scott 사용자에게부여한 emp테이블에 대한 SELECT, INSERT권한이 회수 됩니다..
         만약 scott사용자가 다른 사용자에게 SELECT, INSERT권한을 부여했으면..
         그 권한들도 같이 철회가 됩니다.

WITH GRANT OPTION을 사용하여 객체 권한 취소
  WITH GRANT OPTION을 사용하여 부여한 객체 권한을 취소하면 취소 작업이 
  연쇄적으로 수행 됩니다. 

 시나리오
 1. SCOTT가 KING에게 WITH GRANT OPTION을 사용하여 DEPT테이블의 
    SELECT 권한을 부여 합니다. 
    
2. SYSTEM으로 접속해서 USER를 새로 생성하되 
   USER명은 TEST로 주세요.
    TEST에게 CONNECT, RESOURCE 권한 부여하세요

3. KING이 DEPT테이블의 SELECT권한을 TEST에게 부여 합니다. 

4. TEST로 접속해서 SCOTT의 DEPT테이블을 SELECT해보기

5. SCOTT가 KING에게 부여한 DEPT테이블의 
   SELECT 권한을 취소 합니다. 
   
6. TEST로 접속해서 다시 SCOTT의 DEPT테이블을 SELECT해보기

  

 결과

 - SCOTTt가 KING에게 부여한 DEPT테이블에 대한 SELECT 권한을 취소하면 
   KING이 부여한 TEST유저가 DEPT테이블을 SELECT할 수 있는 권한도 
   자동으로 취소가 됩니다. 
  

 //////////////////////////////////////////////////////////

 ROLE 이란 사용자에게 허가할 수 있는 권한들의 집합 이라고 할 수 있습니다. 

  - ROLE을 이용하면 권한 부여와 회수를 쉽게 할 수 있습니다. 
  - ROLE은 Create Role권한을 가진 User에 의해서 생성 됩니다.　 
  - 한 사용자가 여러개의 ROLL을 ACCESS할 수 있고,  여러 사용자에게 같은 ROLE을 부여할 수 
    있습니다. 
  - 시스템 권한을 부여하고, 취소할 때와 동일한 명령을 사용하여 사용자에게 부여하고, 취소 합니다. 
  - 사용자는 ROLE에 ROLE을 부여할 수 있습니다. 
  - 오라클 데이터베이스를 설치하면 기본적으로 CONNECT, RESOURCE, DBA ROLE이 제공  
    됩니다.
   아래의 그림처럼 DBA가 유저들에게 권한을 부여할 때 일일이 권한 하나하나씩을 지정을 한다면 몹시 불편할 것 입니다. 
   DBA가 USER의 역할에 맞도록 Role을 생성하여서 Role만 유저에게 지정을 한다면 보다 효율적으 로 유저들의 권한을 
   관리 할 수 있습니다. 

ROLE의 생성

문법
ROLE의  부여 순서
 ① ROLE의 생성  :  CREATE ROLE manager
 ② ROLE에 권한 부여 : GRANT create session, create table TO manager
 ③ ROLE을 사용자 또는 ROLE에게 부여 : GRANT manager TO scott, test;
 
 
-- role을 생성 합니다. 
SQL> CREATE ROLE manager

-- role에 권한을 부여 합니다. 
SQL>GRANT create session, create table TO manager

-- 권한이 부여된 role을 user나 role에 부여 합니다. 
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

이 외에도 많이 ROLE이 존재합니다. 
그 중에서 가장 많이 사용하는 3가지만 설명 하겠습니다. 

 
◈ CONNECT
 
- 오라클에 접속 할 수 있는 세션 생성 및 테이블을 생성하거나 
  조회 할 수 있는  가장 일반적인 권한들로 이루어져 있습니다. 

- CONNECT Role이 없으면 유저를 생성하고서도 Oracle에 접속 할 수가 없습니다. 

- 아래의 명령어로 CONNECT Role이 어떤 권한으로 이루어져 있는지 확인 할 수 있습니다.


 SQL>SELECT grantee, privilege 
        FROM DBA_SYS_PRIVS
        WHERE grantee = ’CONNECT’;

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

 
◈ RESOURCE
 - Store Procedure나 Trigger와 같은 PL/SQL을 사용할 수 있는 
   권한 들로 이루어져 있습니다. 
 - PL/SQL을 사용하려면 RESOURCE Role을 부여해야 합니다. 
 - 유저를 생성하면 일반적으로 CONNECT, RESOURCE롤을 부여 합니다. 

SQL>SELECT grantee, privilege 
        FROM DBA_SYS_PRIVS
        WHERE grantee = ’RESOURCE’;
 
◈ DBA
 - 모든 시스템 권한이 부여된 Role입니다.
 - DBA Role은 데이터베이스 관리자에게만 부여해야 합니다.  
  ================================================ 
    * 자료출처: 데이터베이스 정보공유 커뮤니티 oracleclub.com 
    
    
    
    
    
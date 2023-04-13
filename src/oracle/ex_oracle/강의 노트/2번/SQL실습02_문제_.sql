-------------------------------------------------
DDL 문장: CREATE, ALTER, DROP, RENAME
DML 문장: UPDATE,INSERT,DELETE
DCL 문장: GRANT,REVOKE
DATA RETRIEVAL : SELECT
TRANSACTION CONTROL : COMMIT, ROLLBACK, SAVEPOINT
-------------------------------------------------

# 데이터 조작어 -DML

 DML(Data Manipulation Language)

 - 데이터를 입력,수정,삭제 하는 sql명령어
   데이터베이스에 영구적으로 반영되지 않은 데이터 조작 
   명령어들을
   TRANSACTION이라고 하며 
   오러클 에서는 이를 하나의 논리적 작업
   단위로 사용한다.
----------------------------------------------------------------
명령어		설명
----------------------------------------------------------------
INSERT		테이블에 새로운 행 추가
UPDATE		테이블의 행 내용을 변경
DELETE		테이블 행 삭제
COMMIT		저장되지 않은 모든 변경 사항을
		데이터베이스에 저장
SAVEPOINT		savepoint설정
ROLLBACK	저장되지 않은 모든 변경 사항을 취소
----------------------------------------------------------------

[1] INSERT(자료 입력) 문
	1> INSERT INTO 테이블명 VALUES('자료1','자료2','자료3');
	2> INSERT INTO 테이블명(컬럼1,컬럼2,컬럼3)
		VALUES('자료1','자료2','자료3');
	**1>번 방식은 반드시 VALUES() 안의 값이 테이블의
	      컬럼 수와 일치해야 한다.

	**주의: DML 문들은 sqlplus에서 실행후 commit을 해줘야 함
	만약 commit하지 않은 상태로 sqlplus를 종료하면, 이전 처리
	결과를 다시 보여주게 된다.
	반면 데이터를 이전 데이터로 원상 복귀 시키는 명령어는
	rollback이다.
	단, rollback을 하더라도 commit이 수행된 데이터에 대해서는
	취소가 불가능하다.

	**데이터를 주고 받을 때 오러클에서는 SQL명령을 바로 처리하지
	   않고 그 결과를 버퍼에 보관해 두었다가 COMMIT되면 처리함.

	[실습]
	insert into emp(empno,ename,hiredate,deptno)
	values(2222,'SUSAN',SYSDATE,10)
	- INSERT 절의 컬럼은 선택적으로 기입할 수 있다.
	  이럴 경우라도 NOT NULL 제약 조건이 있는 열은 반드시 포함해야 한다.
	- 문자와 날짜 값은 단일 따옴표(' ')를 둘러싼다. 
	   수치값은 (' ')를 사용하지 않음

	[가이드라인]
	* VALUES절을 가지는 INSERT문장은 한번에 오직 하나의 행만 추가한다.
	* 모든 행에 값을 갖는 새로운 행을 삽입할 수 있기 때문에 컬럼리스트는
	   INSERT절에 생략할 수 있다. 하지만 테이블에 정의된 순서에 따라
	   값을 나열해야 한다.
	* 명확성을 위해 INSERT 절에 컬럼 리스트를 사용하면 좋다.
	
	<1> NULL값을 추가할 때는
	- 암시적 방법
		insert into dept(deptno,dname) values(50,'DEVELOPMENT')
	- 명시적 방법
		insert into dept values(60,'',null)
	
	<2> 다른 테이블로부터 행 복사

	- 기존 테이블로부터 값을 가져와 테이블에 추가하기 위해서
	  insert문장을 사용할 수 있다. 이 때 values 절에서 subquery를 사용할 수 있다.
	
	- INSERT INTO table_name [colum1[,colum2,...]]  Subquery;

	[실습]
	create table emp_10(id,name,sal,hiredate)
	as select empno,ename,sal,hiredate from emp
	where 1=2;
	=> 테이블 구조만 복사.

	insert into emp_10
	select empno,ename,sal,hiredate
	from emp where deptno=10;

	==>3개의 행이 복사됨

	-insert 절의 열의 개수와 서브쿼리의 열의 개수가 좌측에서 부터 1대1로
	 대응하며 자료형과 길이가 같아야 한다.

[2] UPDATE문 [자료 수정]

- UPDATE문은 INSERT문에 의해 테이블에 저장된 데이터 값을 
  수정하는 경우에 사용하는 SQL구문.
- WHERE절을 이용하여 여러 개의 데이터 가운데 필요한 
  데이터 값만 수정하면 된다.
  만일 WHERE절을 이용하지 않고 UPDATE를 하면 
  현재 등록된 모든 자료값이 변경된다.

-UPDATE 테이블명 SET 컬럼이름1='자료1', 컬럼이름2='자료2' ....
-UPDATE 테이블명 SET 컬럼이름1='자료1', 컬럼이름2='자료2' ....
  WHERE 조건(컬럼)='조건값'

  [실습]

	create table emp2 as select * from emp;
	=>emp테이블 데이터와 구조를 복사
	
	emp2테이블에서 사번이 7788인 사원의 부서번호를 10으로 
	수정하세요.
	update emp2 set deptno=10 where empno=7788;

	emp2 테이블에서 사번이 7788인 사원의 부서를 20,
	급여를 3500으로 변경하여라.

	update emp2 set deptno=20, sal=3500 where empno=7788;

	emp2테이블에서 부서를 모두 10으로 변경하여라.
	update emp2 set deptno=10;


  [문제]

	 1] 고객 테이블 중 이름이 '김길동'인 사람의 이름을 
	      박길동으로 변경하세요.

	...김길동이 2명일 경우...where조건절을 좀 더 구체적으로 하여 변경한다.


	 2] 등록된 고객 정보 중 고객의 나이를 현재 나이에서 모두 5를 더한 값으로 
	      수정하세요.

	 2_1] 고객 중 13/09/01이후 등록한 고객들의 마일리지를 350점씩 올려주세요.
	

	 3]수정하려는 정보가 문자가 아닌 컬럼이름이나 함수라고 해도 update구문을
	실행하는데 전혀 문제가 없다. 아래 예제 참조.
	
	 4] 등록되어 있는 고객 정보 중 이름에 '김'자가 들어있는 모든 이름을 '김' 대신
	     '최'로 변경하세요.
	

	<1> 다중 열 SUBQUERY로 UPDATE 

		- 다중 열 서브쿼리는 UPDATE문장의 SET 절로 구현할 수 있다.

		EMP2테이블에서 SCOTT의 업무와 급여가 일치하도록
		JONES의 업무와 급여를 변경하여라.

		UPDATE emp2 SET (job,sal)= (
			SELECT job,sal FROM EMP2 WHERE ename='SCOTT')
		WHERE ename='JONES'

	<2> UPDATE시 무결성 제약 조건 에러

	alter table dept add constraint dept_deptno_pk primary key (deptno);

	alter table emp2 add constraint emp2_deptno_fk
	foreign key (deptno) references dept (deptno);

	위의 제약 조건을 준 뒤 아래 문장을 실행해보자.

		UPDATE emp2 SET DEPTNO=91
		WHERE deptno=10;

		=>error: 무결성 제약조건(EMP2_DEPTNO_FK)에 위배-부모키가 없습니다.

		반면,
		UPDATE emp2 SET DEPTNO=20
		WHERE deptno=10;
		
		은 에러가 나지 않는다.
		이는 20이란 부서번호가 DEPT테이블에 존재하기 때문이다.


[3] DELETE 문장-자료 삭제하기

	- 현재 저장된 컬럼의 데이터 중 필요에 의해 해당 데이터를 삭제하는 구문.
	- UPDATE문과 마찬가지로 WHERE 조건을 이용하여 원하는 데이터들만 삭제 가능
	- 모든 데이터를 삭제하려면 WHERE 구문을 빼고 사용하면 된다.

	-DELETE FROM 테이블명  WHERE 조건(컬럼)='조건값'
	-DELETE FROM 테이블명


	[실습]

	- EMP2테이블에서 사원번호가 7499인 사원의 정보를 삭제하라.
		DELETE FROM EMP2 WHERE EMPNO=7499;

	- EMP2테이블에서 입사일자가 83년인 사원의 정보를 삭제하라.
		DELETE FROM EMP2 WHERE to_char(hiredate,'YY')='83';
	
	<1> 다른 테이블을 근거로 한 행 삭제

	- EMP2테이블의 자료 중 부서명이 'SALES'인 사원의 정보를 삭제하라.

	delete from emp2 where deptno=(
	select deptno from dept where dname='SALES');

	<2> 무결성 제약 조건 에러

	- 무결성 제약조건을 위반하도록 행을 삭제하면 에러가 발생한다.
	 delete from dept where dname='ACCOUNTING';

	 ERROR: 무결성 제약 조건(EMP2_DEPTNO_FK)에 위배-자식 레코드가
		   발견되었습니다.


	[문제]

	1] 상품 테이블에 있는 상품 중 상품의 판매 가격이 10000원 이하인 상품을 모두 
	      삭제하세요.


	2] 상품 테이블에 있는 상품 중 상품의 대분류가 도서인 상품을 삭제하세요.


	3] 상품 테이블에 있는 모든 내용을 삭제하세요.


	...일반적으로 프로그램에서 사용하는 
	   delete구문은 삭제하려는 자료 하나만을 삭제
	   하는 것이 대부분이므로 
	   중복되지 않는 고유키값(primary key)을 이용하여 
	   삭제하는 것이 좋은 방법이다.

[4] 데이터베이스 TRANSACTION

- ORACLE 서버는 TRANSACTION을 근거로 하는 
  데이터의 일관성을 보장한다.
- TRANSACTION은 데이터 변경시, 사용자 프로세스 실패나 
  시스템 실패 같은
   사건에서 데이터의 일관성을 책임진다.
- TRANSACTION은 데이터를 일관되게 변경하는 
  DML문장으로 구성된다.
  
   ...모두 성공하던지 아님 모두 실패하던지...

<1> transaction 의 시작과 종류
	
	- transaction 의 시작: 
	실행 가능한 sql문장이 처음 실행될 때
	- transaction 의 종료:
		1) COMMIT이나 ROLLBACK
		2) DDL이나 DCL 문장의 실행(자동 COMMIT)
		3) 기계 장애 또는 시스템 충돌(CRASH)
		4) 사용자의 정상 종료
		5) DEADLOCK발생

<2> commit과 rollback의 장점
	- 데이터의 일관성 제공
	- 데이터를 영구적으로 변경하기 전에 
	  데이터 변경을 확인하게 함
	- 관련된 작업을 논리적으로 그룹화할 수 있음

<3> transaction 제어
----------------------------------------------------------
명령어		설명
----------------------------------------------------------
commit	모든 미결정 데이터를 영구적으로 변경함으로써
		현재 트랜잭션을 종료한다.
----------------------------------------------------------
savepoint	현재 transaction에 대해 savepoint를 표시한다.
----------------------------------------------------------
rollback	모든 미결정 데이터 변경을 취소함으로써 현재의 트랜잭션
[to savepoint 을 종료한다. rollback to savepoint name은 savepoint
name]		 설정 이후의 모든 변경을 취소한다.
----------------------------------------------------------

**DDL과 DCL은 자동적으로 COMMIT되므로 트랜잭션을 암시적으로 
   종료한다.
**savepoint는 ANSI 표준 SQL이 아님.
참고
-------------------------------------------------
DDL 문장: CREATE, ALTER, DROP, RENAME
DML 문장: UPDATE,INSERT,DELETE
DCL 문장: GRANT,REVOKE
DATA RETRIEVAL : SELECT
TRANSACTION CONTROL : COMMIT, ROLLBACK, SAVEPOINT
-------------------------------------------------

[실습]
---------------------------------
UPDATE EMP SET ENAME='CHARSE' WHERE EMPNO=7788;

SELECT * FROM EMP WHERE EMPNO=7788;
ROLLBACK;

SELECT * FROM EMP WHERE EMPNO=7788;
---------------------------------

---------------------------------
UPDATE EMP3 SET DEPTNO=30 WHERE EMPNO=7788;

SAVEPOINT POINT_1;==>저장점이 저장되었습니다.

UPDATE EMP3 SET JOB='MANAGER';==>14개의 행이 갱신

ROLLBACK TO SAVEPOINT POINT_1;
---------------------------------
///////////////////////////////////////////////////////////////////////////////////
# 오러클 객체 구성
1] 오러클 스키마(schema)
	-스키마란 데이터베이스를 구성하는 논리적 구조를 총체적으로 
	지칭하는 말.
	  즉 데이터를 저장하기 위한 논리적인 틀을 의미. 
	  이러한 스키마는 논리적
	  저장구조인 테이블 공간(tablespace)에 저장되는데 
	  이로써 물리적으로는 
	  테이블 공간을  이루는 데이터 파일에 저장 된다.
2] 테이블
	-데이터를 저장하기 위한 가장 기본적인 논리적 데이터 저장 구조.
	  행과 열로 구성됨.
3] 인덱스(Index)
	- 오러클 데이터베이스 테이블 내의 원하는 레코드를 빠르게 찾아갈 수
	   있도록 만들어진 데이터 구조. 
	   즉 하나의 오러클 데이터베이스 테이블에 속하는 각각의 데이터 행은 
	   그 데이터를 검색할 수 있도록 rowid라는 번호가 매겨져 있는데, 
	   이rowid를 통해 데이터베이스는 각각의 데이터 행이 정확히
	   어느 곳에 위치하는지 쉽게 파악할 수 있다.
4] 시퀀스(sequence)
	- 일련번호 생성을 위해서 사용되는 오러클 객체
	  숫자 데이터를 일정한 방향으로 증가하도록 
	  만들어주는 메커니즘.

5] 클러스터(cluster)
	-테이블 데이터를 저장하는 선택적 방법.
	  클러스터는 두 개의 테이블이 서로 같은 항목의 행을 가지고 있을 때
	  사용된다. 클러스터를 사용하지 않으면 두 개의 테이블은 각각 다른
	  위치에 저장되지만, 클러스터를 사용하면 두 테이블은 같은 항목으로,
	  데이터는 같은 위치에 저장됨으로써 저장 공간을 효율적으로 사용할 
	  수 있다.

6] 뷰(view)
	- 가상 테이블. 실제 데이터를 저장하는 데이터 저장 장치가 아니라
	  하나 또는 그 이상의 테이블의 데이터를 참조하여 단순히 보여주는
	  역할만 수행하는 객체.

////////////////////////////////////////////////////////////////////////////////////////
#시퀀스란? 

◈ 유일(UNIQUE)한 값을 생성해주는 오라클 객체다. 
◈ 시퀀스를 생성하면 기본키와 같이 순차적으로 
   증가하는 컬럼을 
   자동적으로 생성할수 있다. 
◈ 보통 primary key 값을 생성하기 위해 사용한다. 
◈ 메모리에 Cache되었을 때 Sequence 값의 
   액세스 효율이 증가 한다. 
◈ Sequence는 테이블과는 독립적으로 저장되고 생성됩니다. 
    따라서 하나의 sequence를  여러 테이블에서 쓸 수 있다

구문
CREATE SEQUENCE 시퀀스명
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}]

START WITH : 시퀀스의 시작 값을 지정합니다. 
	     n을 1로 지정하면 1부터 순차적으로 
                     시퀀스번호가 증가 합니다. 

INCREMENT BY : 시퀀스의 증가 값을 말합니다. 
	     n을 2로 하면 2씩 증가합니다. 
                        START WITH를 1로 하고 INCREMENT BY를 2으로 하면 1, 3, 5,7,.. 이렇게 
                       시퀀스  번호가 증가하게 됩니다. 

MAXVALUE n | NOMAXVALUE : MAXVALUE는 시퀀스가 증가할수 있는 최대값을 말합니다.                                             
NOMAXVALUE는 시퀀스의 값을 무한대로 지정합니다. 

MINVALUE n | NOMINVALUE : MINVALUE는 시퀀스의 최소값을 지정 합니다. 
                                      기본값은 1이며, 
NOMINVALUE를 지정할 경우 최소값은 무한대가 됩니다 

CYCLE | NOCYCLE : 최대 또는 최소값에 도달한 후 계속 값을 생성할지 여부를 지정
		NOCYCLE이 디폴트.
CACHE | NOCACHE : 메모리에 오러클 서버가 미리 할당하고 유지하는 시퀀스의 개수.
		디폴트는 20

[실습]

DEPT테이블의 PK로 사용되는 DEPT_DEPTNO SEQUENCE를 생성하세요.

create sequence dept_deptno
increment by 1
start with 91
maxvalue 99
nocache;
nocycle;

**참고] primary key로 사용될 경우 cycle옵션을 사용해서는 안된다.

SEQUENCE 확인
- 시퀀스를 생성하면 데이터 사전에 등록된다.
- 시퀀스는 USER_OBJECTS 데이터 사전에서 식별할 수 있다.
- 또한 USER_SEQUENCES 테이블을 검색함으로써 SEQUENCE 설정값을 알 수 있다.

[실습]
현재 세션을 이루고 있는 사용자가 소유하고 있는 SEQUENCE를 조회하라.
SELECT sequence_name, min_value,max_value,increment_by, last_number
from USER_SEQUENCES;

# SEQUENCE 사용법

- NEXTVAL, CURRVAL을 사용하여 시퀀스 값을 참조한다.
- NEXTVAL은 다음 사용가능한 시퀀스 값을 반환한다.
- 시퀀스가 참조될 때마다 다른 사용자에게 조차도 유일한 값을 반환한다.
- CURRVAL은 현재 SEQUENCE값을 얻는다.
- CURRVAL이 참조되기 전에 NEXTVAL이 사용되어야 한다.
**참고]
어떤 세션에서 NEXTVAL 을 하지 않은 채 CURRVAL 을 요구하게 되면 에러가 
난다. 그것은 CURRVAL 은 바로 그 세션이 지금 현재 
    가지고 있는 최종 시퀸스 값을 의미 
하므로 한번도 NEXTVAL 을 요구한 적이 없다면 
보유하고 있는 CURRVAL 값이 없기 
때문이다. 

사용규칙 

  ◈ NEXTVAL, CURRVAL을 사용할 수 있는 경우
    - subquery가 아닌 select문
    - insert문의 select절
    - insert문의 value절
    - update문의 set절


  ◈ NEXTVAL, CURRVAL을 사용할 수 없는 경우
    - view의 select절
    - distinct 키워드가 있는 select문
    - group by, having, order by절이 있는 select문
    - select, delete, update의 subquery
    - create table, alter table 명령의 default값

[실습]

	insert into dept values(dept_deptno.nextval,'영업부','종로구 계동');

	select dept_deptno.currval from dual;

#시퀀스값 cache
-시퀀스 값에 대해 보다 빠르게 접근하기 위해 
메모리에 시퀀스를 캐쉬한다.
cache는 시퀀스를 처음 참조할 때 형성된다. 
다음 시퀀스값에 대한 요구가
있으면 메모리에 cache된 값을 읽어들인다. 
마지막 시퀀스가 사용된 후
시퀀스 값에 대한 요구가 있으면 
다시 캐쉬만큼 시퀀스를 메모리에 갖다
놓는다.
# 시퀀스 간격(gap)
- 시퀀스 gap은 아래 상황에서 발생함
1> rollback;
2> system crash
3> sequence가 다른 테이블에서 사용될 떄

**참고] 오러클 서버가 정상종료시, 
메모리에 캐시되어 있던 시퀀스 값에는
gap이 발생하지 않는다.

#시퀀스의 수정 및 삭제 

ALTER SEQUENCE 시퀀스명
[INCREMENT BY n]
[{MAXVALUE n | NOMAXVALE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}]

START WITH는 수정할수 없다. 
START WITH 절이 없다는 점을 빼고는 CREATE SEQUENCE와 같다. 

# 시퀀스 수정지침
- 시퀀스에 대한 소유자이거나 alter권한을 가져야 한다.
- alter 이후에 생성되는 시퀀스 번호에만 영향을 미친다.
- 다른 번호에서 시퀀스를 다시 시작하기 위해서는 제거하고 다시 생성해야 한다.
# 시퀀스 삭제

DROP SEQUENCE 시퀀스명;

drop sequence dept_deptno;
///////////////////////////////////////////////////////////////////////////
#VIEW

[1] VIEW란?

-  하나의 가상 테이블 또는 테이블에 대한 데이터 베이스 
    관리 시스템에 저장된 select구문.
	실제 데이터를 저장하는 데이터 저장장치가 아니라, 
	하나 또는 그 이상의 테이블의
	데이터를 참조하여 단순히 보여주는 역할만 수행한다.
	..데이터를 보거나 변경할 수 있는 창과 같다.

	[장점]
	-데이터의 복잡성을 감소시킴
	-복잡한 질의를 감소시킴
	-기본 테이블의 데이터를 다양한 관점으로 보여줌.

- 테이블에서 자료의 보안이 요구되는 컬럼이 있는 경우 
  이 컬럼을 생략한 내용으로 뷰를 만든 뒤, 
  테이블을 직접 사용하지 않고 뷰를 
  이용해서 데이터를 보안할 수 있다.

[2] 뷰를 만드는 규칙
	CREATE VIEW 뷰이름
	AS
	SELECT 컬럼명1, 컬럼명2...
	FROM 뷰에 사용할 테이블명
	WHERE 조건

	... CREATE VIEW 문장에 SUBQUERY를 내장하여 VIEW를 생성한다.
	** 서브쿼리는 조인,그룹 등 복합 SELECT문을 포함할 수 있고 ORDER BY절을
	    포함할 수 없다.
	    VIEW를 삭제하거나 재생산 하지 않고VIEW의 정의를 변경하려면
	    OR REPLACE옵션을 사용한다.
	...주의] view를 만들기 위해서는 권한이 필요[dba권한으로 CREATE VIEW권한을 주자]


	[실습]
	EMP테이블에서 20번 부서의 모든 컬럼을 포함하는 EMP20_VIEW를 생성하라.
	CREATE VIEW EMP20_VIEW AS SELECT * FROM EMP
	WHERE DEPTNO=20;

	DESC EMP20_VIEW;

	SELECT * FROM EMP20_VIEW;
	-----------------------------------------------
	
	EMP테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME으로
	SAL를 SALARY로 바꾸어 EMP30_VIEW를 생성하여라.

	CREATE VIEW EMP30_VIEW AS SELECT EMPNO EMP_NO,
	ENAME NAME, SAL SALARY FROM EMP 
	WHERE DEPTNO=30;

	SELECT * FROM EMP30_VIEW;
	---------------------------------------------------
	[문제] 
	
	고객테이블의 고객 정보 중 나이가 19세 이상인
	고객의 정보를
	확인하는 뷰를 만들어보세요.
	단 뷰의 이름은 MEMBER_19로 하세요.
	create view member_19 as select * from member where age >=19;


[3] view의 확인
	SELECT view_name, text FROM USER_VIEWS;
	
	desc member_19;
	select name,age,mileage from member_19;

[4] view의 삭제
	drop view member_19;

	- 뷰는 테이블에서 사용하는 select구문을 
	  하나의 가상 테이블로 
	  만들고 그것을  이용한다고 생각하면 된다. 
	  만약 고객 정보가 변동되면 
	  뷰의 내용도 자동으로  변경된다.
	  단, 고객 정보 변동시 commit되어 
	  저장된 내용을 view에 반영한다.

	  또한 alter table등의 명령으로 
	  테이블 구조 자체가 변경되거나 
	  컬럼 이름이 변경되면 뷰의 내용도 
	  함께 변경해야 한다.

	  만약 고객 테이블이 삭제되었다면 view는 어떻게 될까?
	  ...>에러가 남.	


[5] VIEW의 수정

	- OR REPLACE 옵션은 비록 이 이름이 
	  이미 존재할 지라도 VIEW가
	  생성될 수 있도록 해주므로 그 소유자에 대해 
	  이미 만들어져 있는
	  VIEW를 버전업 할 수 있다.

	  CREATE OR REPLACE VIEW EMP20_VIEW
		(EMPLOYEE_NO, EMPLOYEE_NAME,JOB_TITLE)
		AS SELECT EMPNO,ENAME,JOB FROM EMP
		WHERE DEPTNO=20;
	
	- or replace는 emp20_view라는 이름의 view가 존재하면
	  지금 질의에 대한 정의로 대체하고, 존재하지 않는다면
	  새로 create한다.

	[문제1] EMP테이블과 DEPT 테이블을 조인한 뷰를 만들어 보세요.
		create or replace view emp_dept_vw
		
		EMP테이블에서 입사일이 빠른 사람 10명만 얻어오자.[교재275P]
		1) SELECT * FROM EMP ORDER BY HIREDATE;
		2) CREATE OR REPLACE VIEW EMP_HIREDATE_ASCVW
			AS SELECT * FROM EMP ORDER BY HIREDATE;
		3) SELECT ROWNUM,EMPNO,ENAME,HIREDATE 
			FROM EMP_HIREDATE_ASCVW
			WHERE ROWNUM < 11;

[6] DML 연산부정
	- WITH READ ONLY 옵션으로  VIEW를 생성하면 DML문장을
	   수행할 수 없다.
	   
	   create or replace view emp10_view
	   as select empno,ename,job from emp
	   where deptno=10
	   with read only;

[6_2] WITH CHECK OPTION 절

	- WITH CHECK OPTION 절이 있으면 VIEW를 통해
	  수행되는 INSERT와 UPDATE는 VIEW를 가지고
	  검색할 수 없는 행의 생성을 허용하지 않는다.

	  create or replace view emp20vw
	  as select * from emp where deptno=20
	  with check option constraint emp20_ck;

	  update emp20vw set deptno=30
	  where empno=7566;

	
[7] INLINE VIEW

	- 오라클에서는 FROM절에 VIEW를 정의한 질의문을 
	  직접 사용할 수 있도록 지원한다.

	- 가령 위의 [문제A]의 경우 아래와 같이 
	  인라인 뷰를 사용하면 간단히
	   얻을 수 있다.

	   SELECT * FROM (
		  SELECT * FROM EMP ORDER BY HIREDATE
	  ) EMP_VW WHERE ROWNUM <11;

	... 여기서 EMP_VW는 FROM절의 ()안 질의에 대한 별칭이다.
	이를 INLINE VIEW라고 한다. 인라인 뷰는 VIEW의 결과를 
	전체 질의에서 수용할 수 있도록 해준다.
	따라서 매번 별도의 VIEW를 생성하지 않아도 된다.

[8] VIEW에 대한 DML문장 사용 가이드라인
   VIEW가 아래 사항을 포함하는 경우 DML조작이 불가능하다.

   (1)행의 삭제 불가능한 경우
      GROUP BY절, GROUP함수, DISTINCT명령, JOIN조건
   (2) 데이터 수정이 불가능한 경우
      GROUP BY절, GROUP함수, DISTINCT명령, JOIN조건,
      표현식으로 정의된 칼럼(SAL*1.1),
      ROWNUM의 의사열

   (3) 데이터 추가가 불가능한 경우	 
      GROUP BY절, GROUP함수, DISTINCT명령, JOIN조건,
      표현식으로 정의된 칼럼(SAL*1.1),
      ROWNUM의 의사열, 
      view에서 선택되지 않는 not null 컬럼
  
////////////////////////////////
# INDEX
[1] 인덱스란?
 .. 테이블 값을 빠르게 접근하도록 하는 데이터베이스 객체.	
    즉, 보다 빨리 데이터를 검색할 수 있도록 도와주는 
    선택적 구조.
    일반 사전에서 ABCD 순으로 정렬되면 단어를 찾을 때 
    검색이 용이하듯,
    SQL에서는 인덱스를 이용하여 데이터를 신속하게 
    검색하도록 한다.
    
    즉 특정 테이블에서 인덱스를 이용하면 컬럼의 
    자료가 내부에서 순차적으로
    정렬되어 자료 검색시, 정렬된 값을 이용해 자료를 
    검색할 수 있다.
    인덱스를 최적으로 구성하여 사용하면 
    데이터 파일에 대한 I/O를 줄일 수 있고 성능을 
    향상시킬 수 있다.

    그러나 테이블에 과도한 인덱스 사용은 테이블 
    입력,수정,삭제할 때 오히려 많은 과부하를 발생시킬 수 있음.
    따라서 언제,어디에 인덱스를 만들어야 하는지 
    잘 고려해서 사용해야 함.

    1)인덱싱할 테이블 선택
      - 쿼리가 적은 양의 결과를 가져오는 경우 
        테이블에 인덱스를 사용함
        (테이블 전체 행의 10~15%미만이 
	검색 대상이 되는 경우)

      - 수정이 많은 테이블에서는 인덱싱을 하지 않는다.
      - WHERE절이 자주 사용되는 
       테이블에 대해 인덱스를 생성한다.
    
    2) 인덱싱할 컬럼의 결정
      - WHERE 절에서 가장 빈번하게 
        지정되는 컬럼을 선택한다.
      - 유일한 값을 많이 갖지 못한 컬럼은 
        인덱싱하지 않는다.
      - 유일한 값을 갖는 컬럼은 인덱스로 사용함
      - 두 개 이상의 테이블을 조인하기 위해 
        사용되는 컬럼을 인덱싱한다.
      - 자주 수정되는 컬럼은 인덱싱 하지 않는다.

* 인덱스 생성이 불필요한 경우
	- 테이블이 작을 때
	- 테이블이 자주 갱신될 때

    3) INDEX 생성

	- 자동 생성: 
	  PK나 UNIQUE 제약 조건을 정의하면 UNIQUE 인덱스가
	  자동적으로 생성된다.
	- 사용자가 생성: 
	  COLUMN에 UNIQUE인덱스 또는 NON-UNIQUE 인덱스를
	  생성한다.
	* unique index : 지정된 열의 값이 고유함을 보장
	* non-unique index: 지정된 열의 값에 중복을 허용
	-생성방법

	CREATE INDEX 인덱스명 ON 테이블명(컬럼명[,컬럼명]...)

	**주의: 인덱스는 NOT NULL인 컬럼에만 
	  사용할 수 있다.
	  NULL인 경우에는 인덱스를 정렬할 수 없기 
	  때문에 사용 불가.

	  create index emp_ename_idx on emp (ename);

	103]
	고객 테이블에 있는 컬럼 중 NAME 컬럼에 인덱스를 만드세요.
	CREATE INDEX MEMBER_IDX1 ON MEMBER(NAME);

	인덱스 생성시 오러클은 내부적으로 아래 일을 진행한다.
	- 인덱스를 지정한 컬럼 NAME값을 다 읽는다.
	- NAME컬럼 값에 대해 오름차순 정렬을 한다.
	- ROWID와 NAME값을 저장하기 위한 저장공간을 할당한다.
	- 할당 후 값을 저장한다.
	103_1]
	고객 테이블에 있는 컬럼 중 NAME 컬럼에 
	인덱스를 만드세요.
	CREATE INDEX MEMBER_IDX2 ON MEMBER(USERID);

	**잘 만들어졌는지 확인**
	   인덱스명 확인
	- SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS
	   WHERE OBJECT_TYPE='INDEX';
	   또는
	   select index_name,uniqueness from user_indexes
	   where table_name='EMP';

	   생성한 인덱스 컬럼정보는 데이터 사전의 USER_IND_COLUMNS를 통해 확인 가능
        -SELECT TABLE_NAME, COLUMN_NAME FROM USER_IND_COLUMNS
	  WHERE INDEX_NAME='MEMBER_IDX1';

	  테이블과 관련된 인덱스 정보 확인
	-SELECT TABLE_NAME,COLUMN_NAME,INDEX_NAME FROM USER_IND_COLUMNS
	  WHERE TABLE_NAME='PRODUCTS';

	**보통 이름이나 아이디는 고객정보 테이블에서 중복되는 일이 
	   거의 없으면서
	   검색에서 사용되는 컬럼이므로 인덱스를 사용하면 효과적.

	104]
	상품 테이블에서 인덱스를 걸어두면 좋을 컬럼을 찾아 인덱스를 만드세요.
	CREATE INDEX PRODUCTS_IDX1 ON PRODUCTS(CATEGORY_FK);
	CREATE INDEX PRODUCTS_IDX2 ON PRODUCTS(EP_CODE_FK);

    4) INDEX 삭제	
	
	DROP INDEX 삭제할 인덱스명

	인덱스는 수정할 수 없다. 인덱스를 변경하기 위해서는
	인덱스를 제거하고 다시 작성해야 한다.
	DROP INDEX 문장을 실행하여 데이터사전에서 인덱스 정의를
	제거한다.
	인덱스를 제거하기 위해서는 인덱스 소유자이거나
	DROP ANY INDEX권한을 가져야 한다.
//////////////////////////////////////////////////////////////////////////
# SYNONYM(동의어)

- 오라클 객체(테이블,뷰,시퀀스,프로시저)에 대한
  대체이름(ALIAS)을 의미
  즉, 객체에 대한 참조를 의미한다.
  다른 유저의 객체를 참조할 때 많이 사용한다.

- 동의어를 사용시 장점
  1) 객체의 긴 이름을 간편한 이름으로 참조하여
     SQL코딩을 단순화시킬 수 있다.
  2) 객체를 참조하는 사용자의 오브젝트를 감출 수
     있어 보안을 유지할 수 있다.
- 구문
  CREATE [PUBLIC] SYSNONYM 시노님명
  FOR object_name;

  PUBLIC: 모든 사용자가 접근 가능한 시노님을 생성
          한다. PUBLIC시노님의 생성,삭제는 DBA만이
	  할 수 있다.

- 실습-----------------------------
1> 먼저 system으로 연결하여
	사용자 mystar를 생성하고 권한을 주자.
conn system/h301`
create user mystar identified by mystar;
grant connect, resource to mystar;

2>mystar에 연결하여 note라는 테이블 객체를 생성
  하고 레코드를 insert하자.

conn mystar/mystar
create table note(
	no number,
	msg varchar2(30)
);
insert into note values(1,'안녕하세요?');
insert into note values(2,'방가 방가 ^^');
commit;
3> mystar사용자가 scott사용자에게 note테이블을
   조작할 권한을 주자.-ojbect권한
conn mystar/mystar
grant all on note to scott;

3_2>conn scott/tiger
SELECT * FROM mystar.note;

CREATE synonym A FOR mystar.note;
=>ORA-01031: insufficient privileges

4>system으로 연결하여 scott에게 동의어를 생성할
  권한을 준다.-system권한
conn system/h301`
grant create synonym to scott;

5>scott/tiger로 연결하여 mystar의 note테이블에
  대한 동의어를 생성한다.
conn scott/tiger
create synonym A for mystar.note;
==> mystar사용자의 note테이블을 scott사용자가
    A라는 동의어로 사용하겠단 의미

6> 동의어를 이용한 쿼리 전송
select * from A;
==>아래와 동일하다.
select * from mystar.note;
-----------------------------------------------
**데이터사전에서 조회*****
select * from user_objects
where object_type='SYNONYM';
**************************
동의어 삭제
DROP SYNONYM 시노님명;





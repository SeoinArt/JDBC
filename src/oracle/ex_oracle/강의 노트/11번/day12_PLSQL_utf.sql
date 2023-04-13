#제어문
if문
if 조건식 then 실행문;
elsif 조건식 then 실행문;
...
else
    실행문;
end if;
----------------------------------------------
--사번을 인 파라미터로 넘기면 해당 사원의 부서번호,사원명,부서명
--을 출력하는 프로시저
-- 10번부서 '회계부서',20번부서 '연구부서',30 '영업부서', 40 '운영부서'
create or replace procedure dept_search
(pno in number)
is
vdno emp.deptno%type;
vname emp.ename%type;
vdname varchar2(20);
begin
    select deptno, ename
    into vdno, vname
    from emp where empno=pno;
    if vdno=10 then vdname :='회계부서';
    elsif vdno=20 then vdname :='연구부서';
    elsif vdno=30 then vdname :='영업부서';
    else
        vdname:='운영부서';
    end if;
    dbms_output.put_line(pno||'번 '||vname||'님은 '||vdno||'번 부서 ['||vdname||']에 있어요');    
end;
/
set serveroutput on
select empno from emp
exec dept_search(7369);
exec dept_search(7521);

--[실습]
--IF~END IF 문으로 인파라키터로 사원명을 받아 해당 사원의 연봉을 계산하세요.
--COMM이 널일 경우와 널이 아닐 경우를 나눠서 계산하여 출력하세요
create or replace procedure emp_sal
(pname in varchar2)
is
vsal emp.sal%type;
vcomm emp.comm%type;
vtotal number;
begin
    select sal,comm
    into vsal,vcomm
    from emp where ename=upper(pname);
    if vcomm is null then vtotal:=vsal*12;
    else vtotal:=vsal*12+vcomm;
    end if;
    dbms_output.put_line(pname||'님의 연봉은 '||to_char(vtotal,'$999,999')||'입니다');
    dbms_output.put_line('월 급여: '||vsal||', 보너스: '||vcomm);  
    exception
    when no_data_found then 
        dbms_output.put_line(pname||'님은 없습니다');
    when too_many_rows then
        dbms_output.put_line(pname||'님의 데이터가 2건 이상입니다');
end;
/
exec emp_sal('ward');
---------------------------------------------------------------
# 반복문
- for loop
- loop 문
- while loop 문


-[1] for loop

for 변수 in [reverse] 시작값 .. 끝값  loop
  실행문
end loop;
-------------------------------------------
declare
begin
    for i in reverse 10 .. 20 loop
        dbms_output.put_line('Hello '||i);
    end loop;
end;
/
-------------------------------------------
--for 루프문을 이용하면 cursor 를 open, fetch, close 절차가 필요 없다
--자동으로 알아서 함
declare
begin
    for k in (select * from member where job='학생') loop
    -- k 는 record type의 변수
        dbms_output.put_line(k.name||': '||k.job||'  '||k.userid);
    end loop;
end;
/
-------------------------------------------
[2] loop 문

loop
    exit when 조건문;
    실행문;
end loop;
------------------------------------------
--emp테이블에 사원정보를 등록하되 반복문 이용해서
--사번 9000번에서 10씩 증가시켜서 넣읍시다.
--사원명 'james'=>대문자로
--입사일 오늘 날짜로
-- 9090번이 되면 반복문 이탈하기
-- insert문 수행
declare
vno number(4) :=9000;
begin
    loop
        insert into emp(empno,ename,hiredate)
        values(vno,upper('james'), sysdate);
        vno :=vno+10;
        exit when vno>=9090; -- 이 문장이 없으면 무한루프 돈다
    end loop;
    dbms_output.put_line('데이터 삽입 성공 '||(vno-9000)/10||'건의 데이터 입력');    
end;
/

select * from emp order by 1 desc;

rollback;
--------------------------------
[3] while loop문
while 조건문 loop
  실행문
  변수 증감식;  
end loop;
-------------------------------
declare
    cnt number(4) :=1000;
begin
    while cnt <1005 loop
        insert into emp(empno,ename,hiredate)
        values(cnt,'JAMES'||CNT, SYSDATE);
        cnt:=cnt+1;
    end loop;
    dbms_output.put_line(cnt-1000||'건의 데이터 입력 완료');
end;
/
select * from emp
order by 1 asc;
rollback;
------------------------------------------
--# 암시적 커서 사용
--모든 DML문장과 SELECT 문에는 암시적 커서가 존재한다
--개발자가 직접 OPEN,FETCH,CLOSE할 수는 없지만 
--암시적 커서의 속성을 이용해서 정보를 활용할 수 있다.
--
--
--사번을 인파라미터로 넘기면 해당 사원의 급여를 10% 인상시키는 프로시저
--

CREATE OR REPLACE PROCEDURE IMPLICIT_CUSOR
(PNO IN EMP.EMPNO%TYPE)
IS
    VSAL EMP.SAL%TYPE;
    VROW NUMBER;
BEGIN
    SELECT SAL
    INTO VSAL
    FROM EMP WHERE EMPNO=PNO;
    --데이터가 발견된 경우라면 급여를 10%인상시키자
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('검색한 데이터가 있어요: 급여=>'||VSAL);
    END IF;
    
    UPDATE EMP SET SAL=SAL*1.1 WHERE EMPNO=PNO;
    --수정한 데이터 수를 VROW에 저장
    VROW := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('급여가 인상된 사원수: '||VROW);
    
    SELECT SAL
    INTO VSAL
    FROM EMP WHERE EMPNO=PNO;
    --데이터가 발견된 경우라면 급여를 10%인상시키자
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('10% 급여 인상후 : 급여=>'||VSAL);
    END IF;
    
END;
/
EXEC IMPLICIT_CUSOR(7788);
SELECT * FROM EMP;

ROLLBACK;
------------------------------------------------
여러 건의 데이터를 SELECT 하는 문장에 암시적 커서를 사용하면
TOO_MANY_ROWS 에러를 발생시킨다.
==> 이 경우는 명시적 커서를 사용해야 한다
---------------------------------------------------
CREATE OR REPLACE PROCEDURE DEPT_ALL
IS
VNO NUMBER;
VNAME VARCHAR2(30);
VLOC VARCHAR2(30);
BEGIN
    SELECT DEPTNO,DNAME,LOC
    INTO VNO,VNAME,VLOC
    FROM DEPT;
END;
/

EXEC DEPT_ALL;
-- 01422. 00000 -  "exact fetch returns more than requested number of rows"

명시적 커서를 이용해서 문제를 해결해봅시다
선언문에서
CURSOR 커서명 IS SELECT문;

실행문에서
OPEN 커서명;
반복문 이용해서 FETCH해야 함
CLOSE 커서명;
-------------------------
CREATE OR REPLACE PROCEDURE DEPT_ALL
IS
VNO NUMBER;
VNAME VARCHAR2(30);
VLOC VARCHAR2(30);
-- 커서 선언
CURSOR DCR IS 
SELECT DEPTNO,DNAME,LOC
    FROM DEPT;
BEGIN
-- 커서 OPEN
OPEN DCR;
    LOOP
        FETCH DCR INTO VNO,VNAME, VLOC;
        EXIT WHEN DCR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VNO||'  '||RPAD(VNAME,12,' ')||VLOC);
    END LOOP;
-- 커서 CLOSE
CLOSE DCR;    
END;
/
------------------------------------
EXEC DEPT_ALL;

-----------------------------------
--부서별 해당 부서의 부서번호, 부서명과 사원수, 평균급여를 가져와 출력하는
--프로시저를 작성하세요
CREATE OR REPLACE PROCEDURE DEPT_AVG_SAL
IS
VDNO DEPT.DEPTNO%TYPE;
VNAME DEPT.DNAME%TYPE;
VCNT NUMBER;
VAVG_SAL NUMBER;
-- CURSOR선언
CURSOR DCR IS
    SELECT DNAME, COUNT(*), ROUND(AVG(SAL),2)
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    GROUP BY DNAME;        
BEGIN
    OPEN DCR;
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('부서번호   부서명   사원수   평균급여 ');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    LOOP
        FETCH DCR INTO VNAME, VCNT, VAVG_SAL;
        EXIT WHEN DCR%NOTFOUND;
        SELECT DEPTNO INTO VDNO
        FROM DEPT WHERE DNAME=VNAME;        
        DBMS_OUTPUT.PUT_LINE(VDNO||'   '||VNAME||'   '||VCNT||'   '||VAVG_SAL);
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------');               
    END LOOP;
    CLOSE DCR;
END;
/
----------------------------
EXEC DEPT_AVG_SAL;


SELECT DNAME, COUNT(*), ROUND(AVG(SAL),2)
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    GROUP BY DNAME;
---------------------------------------------
- FOR 루프에서 커서 사용
- FOR 루프에서 서브쿼리 사용
----------------------------------------
CREATE OR REPLACE PROCEDURE FORCUR
IS
-- 커서 선언
CURSOR PCR IS
SELECT PRODUCTS_NAME, OUTPUT_PRICE
FROM PRODUCTS ORDER BY 1;
BEGIN
-- FOR 루프에서 커서 사용 (OPEN,FETCH,CLOSE 를 알아서 함)
    FOR P IN PCR LOOP -- P 변수 RECORD 타입
        DBMS_OUTPUT.PUT_LINE(RPAD(P.PRODUCTS_NAME,14,' ')||TO_CHAR(P.OUTPUT_PRICE,'L999,999,999'));
    END LOOP;
END;
/
-----------------------------------------------
EXEC FORCUR;

FOR IN 루프문에 SUBQUERY사용
- CURSOR를 선언할 필요가 없음
- FOR 변수 IN (SUBQUERY) LOOP
        실행문
   END LOOP
-----------------------------
DECLARE
BEGIN
    FOR K IN (SELECT * FROM CATEGORY ORDER BY 3 ASC) LOOP
        DBMS_OUTPUT.PUT_LINE(K.CATEGORY_CODE||LPAD(K.CATEGORY_NAME,16,' '));
    END LOOP;
END;
/
--------------------------------------------
-- 미리 정의된 예외 처리
CREATE OR REPLACE PROCEDURE EXCEPT_TEST
(VDNO IN NUMBER, VENO IN NUMBER, VNAME IN VARCHAR2)
IS
    VEMP EMP%ROWTYPE;
BEGIN
    INSERT INTO EMP(EMPNO,ENAME,DEPTNO)
    VALUES(VENO, VNAME, VDNO);
    
   /* SELECT EMPNO,ENAME,DEPTNO
    INTO VEMP.EMPNO, VEMP.ENAME, VEMP.DEPTNO
    FROM EMP
    WHERE DEPTNO = VDNO;        */
    FOR K IN (SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=VDNO) LOOP    
        DBMS_OUTPUT.PUT_LINE('--------------------------');
        DBMS_OUTPUT.PUT_LINE('사번: '||K.EMPNO);
        DBMS_OUTPUT.PUT_LINE('이름: '||K.ENAME);
        DBMS_OUTPUT.PUT_LINE('부서번호: '||K.DEPTNO);    
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(10/0); -- ZERO_DIVIDE 에러 발생
    EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('데이터가 2건 이상이에요. 커서를 이용하세요');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE(VENO||'번 사원은 이미 있습니다');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('기타 에러 발생: '||SQLERRM||' '||SQLCODE);
END;
/
EXEC EXCEPT_TEST(10,1002,'PETER');
EXEC EXCEPT_TEST(10,1001,'SUSAN');
SELECT * FROM EMP WHERE DEPTNO=10;
ROLLBACK;
ALTER TABLE EMP ADD CONSTRAINT EMP_EMPNO_UK UNIQUE(EMPNO);



SELECT JOB,COUNT(*) FROM EMP GROUP BY JOB;    

-- JOB별로 사원수가 4명보다 적으면 사용자 정의 예외를 발생시켜보자.
-- 인 파라미터로 JOB을 받아서 인원이 4명 미만이면 에러를 발생시킨다

CREATE OR REPLACE PROCEDURE USER_EXCEPT
(PJOB IN EMP.JOB%TYPE)
IS
-- 사용자 정의 예외 선언 [1]
-- 예외이름 EXCEPTION;
    USER_DEFINE_ERROR EXCEPTION;
    VCNT NUMBER;
BEGIN

    SELECT COUNT(empno) 
    INTO VCNT
    FROM EMP
    WHERE JOB=UPPER(PJOB);
    IF VCNT <4 THEN
    -- RAISE문을 이용해 예외 발생 [2]
        RAISE USER_DEFINE_ERROR;
    END IF;
    DBMS_OUTPUT.PUT_LINE(PJOB||'사원 수는 '||VCNT||'명입니다');
EXCEPTION
    -- 예외 처리 단계 RAISE_APPLICATION_ERROR()함수 활용
    WHEN USER_DEFINE_ERROR THEN
        RAISE_APPLICATION_ERROR(-20001,PJOB||'업무에 사원이 너무 적어요. 인원을 늘려주세요');
END;
/
EXECUTE USER_EXCEPT('ANALYST');
EXECUTE USER_EXCEPT('CLERK');

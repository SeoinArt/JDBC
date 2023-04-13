#���
if��
if ���ǽ� then ���๮;
elsif ���ǽ� then ���๮;
...
else
    ���๮;
end if;
----------------------------------------------
--����� �� �Ķ���ͷ� �ѱ�� �ش� ����� �μ���ȣ,�����,�μ���
--�� ����ϴ� ���ν���
-- 10���μ� 'ȸ��μ�',20���μ� '�����μ�',30 '�����μ�', 40 '��μ�'
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
    if vdno=10 then vdname :='ȸ��μ�';
    elsif vdno=20 then vdname :='�����μ�';
    elsif vdno=30 then vdname :='�����μ�';
    else
        vdname:='��μ�';
    end if;
    dbms_output.put_line(pno||'�� '||vname||'���� '||vdno||'�� �μ� ['||vdname||']�� �־��');    
end;
/
set serveroutput on
select empno from emp
exec dept_search(7369);
exec dept_search(7521);

--[�ǽ�]
--IF~END IF ������ ���Ķ�Ű�ͷ� ������� �޾� �ش� ����� ������ ����ϼ���.
--COMM�� ���� ���� ���� �ƴ� ��츦 ������ ����Ͽ� ����ϼ���
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
    dbms_output.put_line(pname||'���� ������ '||to_char(vtotal,'$999,999')||'�Դϴ�');
    dbms_output.put_line('�� �޿�: '||vsal||', ���ʽ�: '||vcomm);  
    exception
    when no_data_found then 
        dbms_output.put_line(pname||'���� �����ϴ�');
    when too_many_rows then
        dbms_output.put_line(pname||'���� �����Ͱ� 2�� �̻��Դϴ�');
end;
/
exec emp_sal('ward');
---------------------------------------------------------------
# �ݺ���
- for loop
- loop ��
- while loop ��


-[1] for loop

for ���� in [reverse] ���۰� .. ����  loop
  ���๮
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
--for �������� �̿��ϸ� cursor �� open, fetch, close ������ �ʿ� ����
--�ڵ����� �˾Ƽ� ��
declare
begin
    for k in (select * from member where job='�л�') loop
    -- k �� record type�� ����
        dbms_output.put_line(k.name||': '||k.job||'  '||k.userid);
    end loop;
end;
/
-------------------------------------------
[2] loop ��

loop
    exit when ���ǹ�;
    ���๮;
end loop;
------------------------------------------
--emp���̺� ��������� ����ϵ� �ݺ��� �̿��ؼ�
--��� 9000������ 10�� �������Ѽ� �����ô�.
--����� 'james'=>�빮�ڷ�
--�Ի��� ���� ��¥��
-- 9090���� �Ǹ� �ݺ��� ��Ż�ϱ�
-- insert�� ����
declare
vno number(4) :=9000;
begin
    loop
        insert into emp(empno,ename,hiredate)
        values(vno,upper('james'), sysdate);
        vno :=vno+10;
        exit when vno>=9090; -- �� ������ ������ ���ѷ��� ����
    end loop;
    dbms_output.put_line('������ ���� ���� '||(vno-9000)/10||'���� ������ �Է�');    
end;
/

select * from emp order by 1 desc;

rollback;
--------------------------------
[3] while loop��
while ���ǹ� loop
  ���๮
  ���� ������;  
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
    dbms_output.put_line(cnt-1000||'���� ������ �Է� �Ϸ�');
end;
/
select * from emp
order by 1 asc;
rollback;
------------------------------------------
--# �Ͻ��� Ŀ�� ���
--��� DML����� SELECT ������ �Ͻ��� Ŀ���� �����Ѵ�
--�����ڰ� ���� OPEN,FETCH,CLOSE�� ���� ������ 
--�Ͻ��� Ŀ���� �Ӽ��� �̿��ؼ� ������ Ȱ���� �� �ִ�.
--
--
--����� ���Ķ���ͷ� �ѱ�� �ش� ����� �޿��� 10% �λ��Ű�� ���ν���
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
    --�����Ͱ� �߰ߵ� ����� �޿��� 10%�λ��Ű��
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�˻��� �����Ͱ� �־��: �޿�=>'||VSAL);
    END IF;
    
    UPDATE EMP SET SAL=SAL*1.1 WHERE EMPNO=PNO;
    --������ ������ ���� VROW�� ����
    VROW := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('�޿��� �λ�� �����: '||VROW);
    
    SELECT SAL
    INTO VSAL
    FROM EMP WHERE EMPNO=PNO;
    --�����Ͱ� �߰ߵ� ����� �޿��� 10%�λ��Ű��
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('10% �޿� �λ��� : �޿�=>'||VSAL);
    END IF;
    
END;
/
EXEC IMPLICIT_CUSOR(7788);
SELECT * FROM EMP;

ROLLBACK;
------------------------------------------------
���� ���� �����͸� SELECT �ϴ� ���忡 �Ͻ��� Ŀ���� ����ϸ�
TOO_MANY_ROWS ������ �߻���Ų��.
==> �� ���� ����� Ŀ���� ����ؾ� �Ѵ�
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

����� Ŀ���� �̿��ؼ� ������ �ذ��غ��ô�
���𹮿���
CURSOR Ŀ���� IS SELECT��;

���๮����
OPEN Ŀ����;
�ݺ��� �̿��ؼ� FETCH�ؾ� ��
CLOSE Ŀ����;
-------------------------
CREATE OR REPLACE PROCEDURE DEPT_ALL
IS
VNO NUMBER;
VNAME VARCHAR2(30);
VLOC VARCHAR2(30);
-- Ŀ�� ����
CURSOR DCR IS 
SELECT DEPTNO,DNAME,LOC
    FROM DEPT;
BEGIN
-- Ŀ�� OPEN
OPEN DCR;
    LOOP
        FETCH DCR INTO VNO,VNAME, VLOC;
        EXIT WHEN DCR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VNO||'  '||RPAD(VNAME,12,' ')||VLOC);
    END LOOP;
-- Ŀ�� CLOSE
CLOSE DCR;    
END;
/
------------------------------------
EXEC DEPT_ALL;

-----------------------------------
--�μ��� �ش� �μ��� �μ���ȣ, �μ���� �����, ��ձ޿��� ������ ����ϴ�
--���ν����� �ۼ��ϼ���
CREATE OR REPLACE PROCEDURE DEPT_AVG_SAL
IS
VDNO DEPT.DEPTNO%TYPE;
VNAME DEPT.DNAME%TYPE;
VCNT NUMBER;
VAVG_SAL NUMBER;
-- CURSOR����
CURSOR DCR IS
    SELECT DNAME, COUNT(*), ROUND(AVG(SAL),2)
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    GROUP BY DNAME;        
BEGIN
    OPEN DCR;
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ   �μ���   �����   ��ձ޿� ');
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
- FOR �������� Ŀ�� ���
- FOR �������� �������� ���
----------------------------------------
CREATE OR REPLACE PROCEDURE FORCUR
IS
-- Ŀ�� ����
CURSOR PCR IS
SELECT PRODUCTS_NAME, OUTPUT_PRICE
FROM PRODUCTS ORDER BY 1;
BEGIN
-- FOR �������� Ŀ�� ��� (OPEN,FETCH,CLOSE �� �˾Ƽ� ��)
    FOR P IN PCR LOOP -- P ���� RECORD Ÿ��
        DBMS_OUTPUT.PUT_LINE(RPAD(P.PRODUCTS_NAME,14,' ')||TO_CHAR(P.OUTPUT_PRICE,'L999,999,999'));
    END LOOP;
END;
/
-----------------------------------------------
EXEC FORCUR;

FOR IN �������� SUBQUERY���
- CURSOR�� ������ �ʿ䰡 ����
- FOR ���� IN (SUBQUERY) LOOP
        ���๮
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
-- �̸� ���ǵ� ���� ó��
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
        DBMS_OUTPUT.PUT_LINE('���: '||K.EMPNO);
        DBMS_OUTPUT.PUT_LINE('�̸�: '||K.ENAME);
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ: '||K.DEPTNO);    
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(10/0); -- ZERO_DIVIDE ���� �߻�
    EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('�����Ͱ� 2�� �̻��̿���. Ŀ���� �̿��ϼ���');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE(VENO||'�� ����� �̹� �ֽ��ϴ�');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('��Ÿ ���� �߻�: '||SQLERRM||' '||SQLCODE);
END;
/
EXEC EXCEPT_TEST(10,1002,'PETER');
EXEC EXCEPT_TEST(10,1001,'SUSAN');
SELECT * FROM EMP WHERE DEPTNO=10;
ROLLBACK;
ALTER TABLE EMP ADD CONSTRAINT EMP_EMPNO_UK UNIQUE(EMPNO);



SELECT JOB,COUNT(*) FROM EMP GROUP BY JOB;    

-- JOB���� ������� 4���� ������ ����� ���� ���ܸ� �߻����Ѻ���.
-- �� �Ķ���ͷ� JOB�� �޾Ƽ� �ο��� 4�� �̸��̸� ������ �߻���Ų��

CREATE OR REPLACE PROCEDURE USER_EXCEPT
(PJOB IN EMP.JOB%TYPE)
IS
-- ����� ���� ���� ���� [1]
-- �����̸� EXCEPTION;
    USER_DEFINE_ERROR EXCEPTION;
    VCNT NUMBER;
BEGIN

    SELECT COUNT(empno) 
    INTO VCNT
    FROM EMP
    WHERE JOB=UPPER(PJOB);
    IF VCNT <4 THEN
    -- RAISE���� �̿��� ���� �߻� [2]
        RAISE USER_DEFINE_ERROR;
    END IF;
    DBMS_OUTPUT.PUT_LINE(PJOB||'��� ���� '||VCNT||'���Դϴ�');
EXCEPTION
    -- ���� ó�� �ܰ� RAISE_APPLICATION_ERROR()�Լ� Ȱ��
    WHEN USER_DEFINE_ERROR THEN
        RAISE_APPLICATION_ERROR(-20001,PJOB||'������ ����� �ʹ� �����. �ο��� �÷��ּ���');
END;
/
EXECUTE USER_EXCEPT('ANALYST');
EXECUTE USER_EXCEPT('CLERK');

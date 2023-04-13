-------------------------------------------------
DDL ����: CREATE, ALTER, DROP, RENAME
DML ����: UPDATE,INSERT,DELETE
DCL ����: GRANT,REVOKE
DATA RETRIEVAL : SELECT
TRANSACTION CONTROL : COMMIT, ROLLBACK, SAVEPOINT
-------------------------------------------------

# ������ ���۾� -DML

 DML(Data Manipulation Language)

 - �����͸� �Է�,����,���� �ϴ� sql��ɾ�
   �����ͺ��̽��� ���������� �ݿ����� ���� ������ ���� 
   ��ɾ����
   TRANSACTION�̶�� �ϸ� 
   ����Ŭ ������ �̸� �ϳ��� ���� �۾�
   ������ ����Ѵ�.
----------------------------------------------------------------
��ɾ�		����
----------------------------------------------------------------
INSERT		���̺� ���ο� �� �߰�
UPDATE		���̺��� �� ������ ����
DELETE		���̺� �� ����
COMMIT		������� ���� ��� ���� ������
		�����ͺ��̽��� ����
SAVEPOINT		savepoint����
ROLLBACK	������� ���� ��� ���� ������ ���
----------------------------------------------------------------

[1] INSERT(�ڷ� �Է�) ��
	1> INSERT INTO ���̺�� VALUES('�ڷ�1','�ڷ�2','�ڷ�3');
	2> INSERT INTO ���̺��(�÷�1,�÷�2,�÷�3)
		VALUES('�ڷ�1','�ڷ�2','�ڷ�3');
	**1>�� ����� �ݵ�� VALUES() ���� ���� ���̺���
	      �÷� ���� ��ġ�ؾ� �Ѵ�.

	**����: DML ������ sqlplus���� ������ commit�� ����� ��
	���� commit���� ���� ���·� sqlplus�� �����ϸ�, ���� ó��
	����� �ٽ� �����ְ� �ȴ�.
	�ݸ� �����͸� ���� �����ͷ� ���� ���� ��Ű�� ��ɾ��
	rollback�̴�.
	��, rollback�� �ϴ��� commit�� ����� �����Ϳ� ���ؼ���
	��Ұ� �Ұ����ϴ�.

	**�����͸� �ְ� ���� �� ����Ŭ������ SQL����� �ٷ� ó������
	   �ʰ� �� ����� ���ۿ� ������ �ξ��ٰ� COMMIT�Ǹ� ó����.

	[�ǽ�]
	insert into emp(empno,ename,hiredate,deptno)
	values(2222,'SUSAN',SYSDATE,10)
	- INSERT ���� �÷��� ���������� ������ �� �ִ�.
	  �̷� ���� NOT NULL ���� ������ �ִ� ���� �ݵ�� �����ؾ� �Ѵ�.
	- ���ڿ� ��¥ ���� ���� ����ǥ(' ')�� �ѷ��Ѵ�. 
	   ��ġ���� (' ')�� ������� ����

	[���̵����]
	* VALUES���� ������ INSERT������ �ѹ��� ���� �ϳ��� �ุ �߰��Ѵ�.
	* ��� �࿡ ���� ���� ���ο� ���� ������ �� �ֱ� ������ �÷�����Ʈ��
	   INSERT���� ������ �� �ִ�. ������ ���̺� ���ǵ� ������ ����
	   ���� �����ؾ� �Ѵ�.
	* ��Ȯ���� ���� INSERT ���� �÷� ����Ʈ�� ����ϸ� ����.
	
	<1> NULL���� �߰��� ����
	- �Ͻ��� ���
		insert into dept(deptno,dname) values(50,'DEVELOPMENT')
	- ����� ���
		insert into dept values(60,'',null)
	
	<2> �ٸ� ���̺�κ��� �� ����

	- ���� ���̺�κ��� ���� ������ ���̺� �߰��ϱ� ���ؼ�
	  insert������ ����� �� �ִ�. �� �� values ������ subquery�� ����� �� �ִ�.
	
	- INSERT INTO table_name [colum1[,colum2,...]]  Subquery;

	[�ǽ�]
	create table emp_10(id,name,sal,hiredate)
	as select empno,ename,sal,hiredate from emp
	where 1=2;
	=> ���̺� ������ ����.

	insert into emp_10
	select empno,ename,sal,hiredate
	from emp where deptno=10;

	==>3���� ���� �����

	-insert ���� ���� ������ ���������� ���� ������ �������� ���� 1��1��
	 �����ϸ� �ڷ����� ���̰� ���ƾ� �Ѵ�.

[2] UPDATE�� [�ڷ� ����]

- UPDATE���� INSERT���� ���� ���̺� ����� ������ ���� 
  �����ϴ� ��쿡 ����ϴ� SQL����.
- WHERE���� �̿��Ͽ� ���� ���� ������ ��� �ʿ��� 
  ������ ���� �����ϸ� �ȴ�.
  ���� WHERE���� �̿����� �ʰ� UPDATE�� �ϸ� 
  ���� ��ϵ� ��� �ڷᰪ�� ����ȴ�.

-UPDATE ���̺�� SET �÷��̸�1='�ڷ�1', �÷��̸�2='�ڷ�2' ....
-UPDATE ���̺�� SET �÷��̸�1='�ڷ�1', �÷��̸�2='�ڷ�2' ....
  WHERE ����(�÷�)='���ǰ�'

  [�ǽ�]

	create table emp2 as select * from emp;
	=>emp���̺� �����Ϳ� ������ ����
	
	emp2���̺��� ����� 7788�� ����� �μ���ȣ�� 10���� 
	�����ϼ���.
	update emp2 set deptno=10 where empno=7788;

	emp2 ���̺��� ����� 7788�� ����� �μ��� 20,
	�޿��� 3500���� �����Ͽ���.

	update emp2 set deptno=20, sal=3500 where empno=7788;

	emp2���̺��� �μ��� ��� 10���� �����Ͽ���.
	update emp2 set deptno=10;


  [����]

	 1] �� ���̺� �� �̸��� '��浿'�� ����� �̸��� 
	      �ڱ浿���� �����ϼ���.

	...��浿�� 2���� ���...where�������� �� �� ��ü������ �Ͽ� �����Ѵ�.


	 2] ��ϵ� �� ���� �� ���� ���̸� ���� ���̿��� ��� 5�� ���� ������ 
	      �����ϼ���.

	 2_1] �� �� 13/09/01���� ����� ������ ���ϸ����� 350���� �÷��ּ���.
	

	 3]�����Ϸ��� ������ ���ڰ� �ƴ� �÷��̸��̳� �Լ���� �ص� update������
	�����ϴµ� ���� ������ ����. �Ʒ� ���� ����.
	
	 4] ��ϵǾ� �ִ� �� ���� �� �̸��� '��'�ڰ� ����ִ� ��� �̸��� '��' ���
	     '��'�� �����ϼ���.
	

	<1> ���� �� SUBQUERY�� UPDATE 

		- ���� �� ���������� UPDATE������ SET ���� ������ �� �ִ�.

		EMP2���̺��� SCOTT�� ������ �޿��� ��ġ�ϵ���
		JONES�� ������ �޿��� �����Ͽ���.

		UPDATE emp2 SET (job,sal)= (
			SELECT job,sal FROM EMP2 WHERE ename='SCOTT')
		WHERE ename='JONES'

	<2> UPDATE�� ���Ἲ ���� ���� ����

	alter table dept add constraint dept_deptno_pk primary key (deptno);

	alter table emp2 add constraint emp2_deptno_fk
	foreign key (deptno) references dept (deptno);

	���� ���� ������ �� �� �Ʒ� ������ �����غ���.

		UPDATE emp2 SET DEPTNO=91
		WHERE deptno=10;

		=>error: ���Ἲ ��������(EMP2_DEPTNO_FK)�� ����-�θ�Ű�� �����ϴ�.

		�ݸ�,
		UPDATE emp2 SET DEPTNO=20
		WHERE deptno=10;
		
		�� ������ ���� �ʴ´�.
		�̴� 20�̶� �μ���ȣ�� DEPT���̺� �����ϱ� �����̴�.


[3] DELETE ����-�ڷ� �����ϱ�

	- ���� ����� �÷��� ������ �� �ʿ信 ���� �ش� �����͸� �����ϴ� ����.
	- UPDATE���� ���������� WHERE ������ �̿��Ͽ� ���ϴ� �����͵鸸 ���� ����
	- ��� �����͸� �����Ϸ��� WHERE ������ ���� ����ϸ� �ȴ�.

	-DELETE FROM ���̺��  WHERE ����(�÷�)='���ǰ�'
	-DELETE FROM ���̺��


	[�ǽ�]

	- EMP2���̺��� �����ȣ�� 7499�� ����� ������ �����϶�.
		DELETE FROM EMP2 WHERE EMPNO=7499;

	- EMP2���̺��� �Ի����ڰ� 83���� ����� ������ �����϶�.
		DELETE FROM EMP2 WHERE to_char(hiredate,'YY')='83';
	
	<1> �ٸ� ���̺��� �ٰŷ� �� �� ����

	- EMP2���̺��� �ڷ� �� �μ����� 'SALES'�� ����� ������ �����϶�.

	delete from emp2 where deptno=(
	select deptno from dept where dname='SALES');

	<2> ���Ἲ ���� ���� ����

	- ���Ἲ ���������� �����ϵ��� ���� �����ϸ� ������ �߻��Ѵ�.
	 delete from dept where dname='ACCOUNTING';

	 ERROR: ���Ἲ ���� ����(EMP2_DEPTNO_FK)�� ����-�ڽ� ���ڵ尡
		   �߰ߵǾ����ϴ�.


	[����]

	1] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� �Ǹ� ������ 10000�� ������ ��ǰ�� ��� 
	      �����ϼ���.


	2] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� ��з��� ������ ��ǰ�� �����ϼ���.


	3] ��ǰ ���̺� �ִ� ��� ������ �����ϼ���.


	...�Ϲ������� ���α׷����� ����ϴ� 
	   delete������ �����Ϸ��� �ڷ� �ϳ����� ����
	   �ϴ� ���� ��κ��̹Ƿ� 
	   �ߺ����� �ʴ� ����Ű��(primary key)�� �̿��Ͽ� 
	   �����ϴ� ���� ���� ����̴�.

[4] �����ͺ��̽� TRANSACTION

- ORACLE ������ TRANSACTION�� �ٰŷ� �ϴ� 
  �������� �ϰ����� �����Ѵ�.
- TRANSACTION�� ������ �����, ����� ���μ��� ���г� 
  �ý��� ���� ����
   ��ǿ��� �������� �ϰ����� å������.
- TRANSACTION�� �����͸� �ϰ��ǰ� �����ϴ� 
  DML�������� �����ȴ�.
  
   ...��� �����ϴ��� �ƴ� ��� �����ϴ���...

<1> transaction �� ���۰� ����
	
	- transaction �� ����: 
	���� ������ sql������ ó�� ����� ��
	- transaction �� ����:
		1) COMMIT�̳� ROLLBACK
		2) DDL�̳� DCL ������ ����(�ڵ� COMMIT)
		3) ��� ��� �Ǵ� �ý��� �浹(CRASH)
		4) ������� ���� ����
		5) DEADLOCK�߻�

<2> commit�� rollback�� ����
	- �������� �ϰ��� ����
	- �����͸� ���������� �����ϱ� ���� 
	  ������ ������ Ȯ���ϰ� ��
	- ���õ� �۾��� �������� �׷�ȭ�� �� ����

<3> transaction ����
----------------------------------------------------------
��ɾ�		����
----------------------------------------------------------
commit	��� �̰��� �����͸� ���������� ���������ν�
		���� Ʈ������� �����Ѵ�.
----------------------------------------------------------
savepoint	���� transaction�� ���� savepoint�� ǥ���Ѵ�.
----------------------------------------------------------
rollback	��� �̰��� ������ ������ ��������ν� ������ Ʈ�����
[to savepoint �� �����Ѵ�. rollback to savepoint name�� savepoint
name]		 ���� ������ ��� ������ ����Ѵ�.
----------------------------------------------------------

**DDL�� DCL�� �ڵ������� COMMIT�ǹǷ� Ʈ������� �Ͻ������� 
   �����Ѵ�.
**savepoint�� ANSI ǥ�� SQL�� �ƴ�.
����
-------------------------------------------------
DDL ����: CREATE, ALTER, DROP, RENAME
DML ����: UPDATE,INSERT,DELETE
DCL ����: GRANT,REVOKE
DATA RETRIEVAL : SELECT
TRANSACTION CONTROL : COMMIT, ROLLBACK, SAVEPOINT
-------------------------------------------------

[�ǽ�]
---------------------------------
UPDATE EMP SET ENAME='CHARSE' WHERE EMPNO=7788;

SELECT * FROM EMP WHERE EMPNO=7788;
ROLLBACK;

SELECT * FROM EMP WHERE EMPNO=7788;
---------------------------------

---------------------------------
UPDATE EMP3 SET DEPTNO=30 WHERE EMPNO=7788;

SAVEPOINT POINT_1;==>�������� ����Ǿ����ϴ�.

UPDATE EMP3 SET JOB='MANAGER';==>14���� ���� ����

ROLLBACK TO SAVEPOINT POINT_1;
---------------------------------
///////////////////////////////////////////////////////////////////////////////////
# ����Ŭ ��ü ����
1] ����Ŭ ��Ű��(schema)
	-��Ű���� �����ͺ��̽��� �����ϴ� ���� ������ ��ü������ 
	��Ī�ϴ� ��.
	  �� �����͸� �����ϱ� ���� ������ Ʋ�� �ǹ�. 
	  �̷��� ��Ű���� ����
	  ���屸���� ���̺� ����(tablespace)�� ����Ǵµ� 
	  �̷ν� ���������δ� 
	  ���̺� ������  �̷�� ������ ���Ͽ� ���� �ȴ�.
2] ���̺�
	-�����͸� �����ϱ� ���� ���� �⺻���� ���� ������ ���� ����.
	  ��� ���� ������.
3] �ε���(Index)
	- ����Ŭ �����ͺ��̽� ���̺� ���� ���ϴ� ���ڵ带 ������ ã�ư� ��
	   �ֵ��� ������� ������ ����. 
	   �� �ϳ��� ����Ŭ �����ͺ��̽� ���̺� ���ϴ� ������ ������ ���� 
	   �� �����͸� �˻��� �� �ֵ��� rowid��� ��ȣ�� �Ű��� �ִµ�, 
	   ��rowid�� ���� �����ͺ��̽��� ������ ������ ���� ��Ȯ��
	   ��� ���� ��ġ�ϴ��� ���� �ľ��� �� �ִ�.
4] ������(sequence)
	- �Ϸù�ȣ ������ ���ؼ� ���Ǵ� ����Ŭ ��ü
	  ���� �����͸� ������ �������� �����ϵ��� 
	  ������ִ� ��Ŀ����.

5] Ŭ������(cluster)
	-���̺� �����͸� �����ϴ� ������ ���.
	  Ŭ�����ʹ� �� ���� ���̺��� ���� ���� �׸��� ���� ������ ���� ��
	  ���ȴ�. Ŭ�����͸� ������� ������ �� ���� ���̺��� ���� �ٸ�
	  ��ġ�� ���������, Ŭ�����͸� ����ϸ� �� ���̺��� ���� �׸�����,
	  �����ʹ� ���� ��ġ�� ��������ν� ���� ������ ȿ�������� ����� 
	  �� �ִ�.

6] ��(view)
	- ���� ���̺�. ���� �����͸� �����ϴ� ������ ���� ��ġ�� �ƴ϶�
	  �ϳ� �Ǵ� �� �̻��� ���̺��� �����͸� �����Ͽ� �ܼ��� �����ִ�
	  ���Ҹ� �����ϴ� ��ü.

////////////////////////////////////////////////////////////////////////////////////////
#��������? 

�� ����(UNIQUE)�� ���� �������ִ� ����Ŭ ��ü��. 
�� �������� �����ϸ� �⺻Ű�� ���� ���������� 
   �����ϴ� �÷��� 
   �ڵ������� �����Ҽ� �ִ�. 
�� ���� primary key ���� �����ϱ� ���� ����Ѵ�. 
�� �޸𸮿� Cache�Ǿ��� �� Sequence ���� 
   �׼��� ȿ���� ���� �Ѵ�. 
�� Sequence�� ���̺���� ���������� ����ǰ� �����˴ϴ�. 
    ���� �ϳ��� sequence��  ���� ���̺��� �� �� �ִ�

����
CREATE SEQUENCE ��������
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}]

START WITH : �������� ���� ���� �����մϴ�. 
	     n�� 1�� �����ϸ� 1���� ���������� 
                     ��������ȣ�� ���� �մϴ�. 

INCREMENT BY : �������� ���� ���� ���մϴ�. 
	     n�� 2�� �ϸ� 2�� �����մϴ�. 
                        START WITH�� 1�� �ϰ� INCREMENT BY�� 2���� �ϸ� 1, 3, 5,7,.. �̷��� 
                       ������  ��ȣ�� �����ϰ� �˴ϴ�. 

MAXVALUE n | NOMAXVALUE : MAXVALUE�� �������� �����Ҽ� �ִ� �ִ밪�� ���մϴ�.                                             
NOMAXVALUE�� �������� ���� ���Ѵ�� �����մϴ�. 

MINVALUE n | NOMINVALUE : MINVALUE�� �������� �ּҰ��� ���� �մϴ�. 
                                      �⺻���� 1�̸�, 
NOMINVALUE�� ������ ��� �ּҰ��� ���Ѵ밡 �˴ϴ� 

CYCLE | NOCYCLE : �ִ� �Ǵ� �ּҰ��� ������ �� ��� ���� �������� ���θ� ����
		NOCYCLE�� ����Ʈ.
CACHE | NOCACHE : �޸𸮿� ����Ŭ ������ �̸� �Ҵ��ϰ� �����ϴ� �������� ����.
		����Ʈ�� 20

[�ǽ�]

DEPT���̺��� PK�� ���Ǵ� DEPT_DEPTNO SEQUENCE�� �����ϼ���.

create sequence dept_deptno
increment by 1
start with 91
maxvalue 99
nocache;
nocycle;

**����] primary key�� ���� ��� cycle�ɼ��� ����ؼ��� �ȵȴ�.

SEQUENCE Ȯ��
- �������� �����ϸ� ������ ������ ��ϵȴ�.
- �������� USER_OBJECTS ������ �������� �ĺ��� �� �ִ�.
- ���� USER_SEQUENCES ���̺��� �˻������ν� SEQUENCE �������� �� �� �ִ�.

[�ǽ�]
���� ������ �̷�� �ִ� ����ڰ� �����ϰ� �ִ� SEQUENCE�� ��ȸ�϶�.
SELECT sequence_name, min_value,max_value,increment_by, last_number
from USER_SEQUENCES;

# SEQUENCE ����

- NEXTVAL, CURRVAL�� ����Ͽ� ������ ���� �����Ѵ�.
- NEXTVAL�� ���� ��밡���� ������ ���� ��ȯ�Ѵ�.
- �������� ������ ������ �ٸ� ����ڿ��� ������ ������ ���� ��ȯ�Ѵ�.
- CURRVAL�� ���� SEQUENCE���� ��´�.
- CURRVAL�� �����Ǳ� ���� NEXTVAL�� ���Ǿ�� �Ѵ�.
**����]
� ���ǿ��� NEXTVAL �� ���� ���� ä CURRVAL �� �䱸�ϰ� �Ǹ� ������ 
����. �װ��� CURRVAL �� �ٷ� �� ������ ���� ���� 
    ������ �ִ� ���� ������ ���� �ǹ� 
�ϹǷ� �ѹ��� NEXTVAL �� �䱸�� ���� ���ٸ� 
�����ϰ� �ִ� CURRVAL ���� ���� 
�����̴�. 

����Ģ 

  �� NEXTVAL, CURRVAL�� ����� �� �ִ� ���
    - subquery�� �ƴ� select��
    - insert���� select��
    - insert���� value��
    - update���� set��


  �� NEXTVAL, CURRVAL�� ����� �� ���� ���
    - view�� select��
    - distinct Ű���尡 �ִ� select��
    - group by, having, order by���� �ִ� select��
    - select, delete, update�� subquery
    - create table, alter table ����� default��

[�ǽ�]

	insert into dept values(dept_deptno.nextval,'������','���α� �赿');

	select dept_deptno.currval from dual;

#�������� cache
-������ ���� ���� ���� ������ �����ϱ� ���� 
�޸𸮿� �������� ĳ���Ѵ�.
cache�� �������� ó�� ������ �� �����ȴ�. 
���� ���������� ���� �䱸��
������ �޸𸮿� cache�� ���� �о���δ�. 
������ �������� ���� ��
������ ���� ���� �䱸�� ������ 
�ٽ� ĳ����ŭ �������� �޸𸮿� ����
���´�.
# ������ ����(gap)
- ������ gap�� �Ʒ� ��Ȳ���� �߻���
1> rollback;
2> system crash
3> sequence�� �ٸ� ���̺��� ���� ��

**����] ����Ŭ ������ ���������, 
�޸𸮿� ĳ�õǾ� �ִ� ������ ������
gap�� �߻����� �ʴ´�.

#�������� ���� �� ���� 

ALTER SEQUENCE ��������
[INCREMENT BY n]
[{MAXVALUE n | NOMAXVALE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}]

START WITH�� �����Ҽ� ����. 
START WITH ���� ���ٴ� ���� ����� CREATE SEQUENCE�� ����. 

# ������ ������ħ
- �������� ���� �������̰ų� alter������ ������ �Ѵ�.
- alter ���Ŀ� �����Ǵ� ������ ��ȣ���� ������ ��ģ��.
- �ٸ� ��ȣ���� �������� �ٽ� �����ϱ� ���ؼ��� �����ϰ� �ٽ� �����ؾ� �Ѵ�.
# ������ ����

DROP SEQUENCE ��������;

drop sequence dept_deptno;
///////////////////////////////////////////////////////////////////////////
#VIEW

[1] VIEW��?

-  �ϳ��� ���� ���̺� �Ǵ� ���̺� ���� ������ ���̽� 
    ���� �ý��ۿ� ����� select����.
	���� �����͸� �����ϴ� ������ ������ġ�� �ƴ϶�, 
	�ϳ� �Ǵ� �� �̻��� ���̺���
	�����͸� �����Ͽ� �ܼ��� �����ִ� ���Ҹ� �����Ѵ�.
	..�����͸� ���ų� ������ �� �ִ� â�� ����.

	[����]
	-�������� ���⼺�� ���ҽ�Ŵ
	-������ ���Ǹ� ���ҽ�Ŵ
	-�⺻ ���̺��� �����͸� �پ��� �������� ������.

- ���̺��� �ڷ��� ������ �䱸�Ǵ� �÷��� �ִ� ��� 
  �� �÷��� ������ �������� �並 ���� ��, 
  ���̺��� ���� ������� �ʰ� �並 
  �̿��ؼ� �����͸� ������ �� �ִ�.

[2] �並 ����� ��Ģ
	CREATE VIEW ���̸�
	AS
	SELECT �÷���1, �÷���2...
	FROM �信 ����� ���̺��
	WHERE ����

	... CREATE VIEW ���忡 SUBQUERY�� �����Ͽ� VIEW�� �����Ѵ�.
	** ���������� ����,�׷� �� ���� SELECT���� ������ �� �ְ� ORDER BY����
	    ������ �� ����.
	    VIEW�� �����ϰų� ����� ���� �ʰ�VIEW�� ���Ǹ� �����Ϸ���
	    OR REPLACE�ɼ��� ����Ѵ�.
	...����] view�� ����� ���ؼ��� ������ �ʿ�[dba�������� CREATE VIEW������ ����]


	[�ǽ�]
	EMP���̺��� 20�� �μ��� ��� �÷��� �����ϴ� EMP20_VIEW�� �����϶�.
	CREATE VIEW EMP20_VIEW AS SELECT * FROM EMP
	WHERE DEPTNO=20;

	DESC EMP20_VIEW;

	SELECT * FROM EMP20_VIEW;
	-----------------------------------------------
	
	EMP���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
	SAL�� SALARY�� �ٲپ� EMP30_VIEW�� �����Ͽ���.

	CREATE VIEW EMP30_VIEW AS SELECT EMPNO EMP_NO,
	ENAME NAME, SAL SALARY FROM EMP 
	WHERE DEPTNO=30;

	SELECT * FROM EMP30_VIEW;
	---------------------------------------------------
	[����] 
	
	�����̺��� �� ���� �� ���̰� 19�� �̻���
	���� ������
	Ȯ���ϴ� �並 ��������.
	�� ���� �̸��� MEMBER_19�� �ϼ���.
	create view member_19 as select * from member where age >=19;


[3] view�� Ȯ��
	SELECT view_name, text FROM USER_VIEWS;
	
	desc member_19;
	select name,age,mileage from member_19;

[4] view�� ����
	drop view member_19;

	- ��� ���̺��� ����ϴ� select������ 
	  �ϳ��� ���� ���̺�� 
	  ����� �װ���  �̿��Ѵٰ� �����ϸ� �ȴ�. 
	  ���� �� ������ �����Ǹ� 
	  ���� ���뵵 �ڵ�����  ����ȴ�.
	  ��, �� ���� ������ commit�Ǿ� 
	  ����� ������ view�� �ݿ��Ѵ�.

	  ���� alter table���� ������� 
	  ���̺� ���� ��ü�� ����ǰų� 
	  �÷� �̸��� ����Ǹ� ���� ���뵵 
	  �Բ� �����ؾ� �Ѵ�.

	  ���� �� ���̺��� �����Ǿ��ٸ� view�� ��� �ɱ�?
	  ...>������ ��.	


[5] VIEW�� ����

	- OR REPLACE �ɼ��� ��� �� �̸��� 
	  �̹� ������ ���� VIEW��
	  ������ �� �ֵ��� ���ֹǷ� �� �����ڿ� ���� 
	  �̹� ������� �ִ�
	  VIEW�� ������ �� �� �ִ�.

	  CREATE OR REPLACE VIEW EMP20_VIEW
		(EMPLOYEE_NO, EMPLOYEE_NAME,JOB_TITLE)
		AS SELECT EMPNO,ENAME,JOB FROM EMP
		WHERE DEPTNO=20;
	
	- or replace�� emp20_view��� �̸��� view�� �����ϸ�
	  ���� ���ǿ� ���� ���Ƿ� ��ü�ϰ�, �������� �ʴ´ٸ�
	  ���� create�Ѵ�.

	[����1] EMP���̺�� DEPT ���̺��� ������ �並 ����� ������.
		create or replace view emp_dept_vw
		
		EMP���̺��� �Ի����� ���� ��� 10�� ������.[����275P]
		1) SELECT * FROM EMP ORDER BY HIREDATE;
		2) CREATE OR REPLACE VIEW EMP_HIREDATE_ASCVW
			AS SELECT * FROM EMP ORDER BY HIREDATE;
		3) SELECT ROWNUM,EMPNO,ENAME,HIREDATE 
			FROM EMP_HIREDATE_ASCVW
			WHERE ROWNUM < 11;

[6] DML �������
	- WITH READ ONLY �ɼ�����  VIEW�� �����ϸ� DML������
	   ������ �� ����.
	   
	   create or replace view emp10_view
	   as select empno,ename,job from emp
	   where deptno=10
	   with read only;

[6_2] WITH CHECK OPTION ��

	- WITH CHECK OPTION ���� ������ VIEW�� ����
	  ����Ǵ� INSERT�� UPDATE�� VIEW�� ������
	  �˻��� �� ���� ���� ������ ������� �ʴ´�.

	  create or replace view emp20vw
	  as select * from emp where deptno=20
	  with check option constraint emp20_ck;

	  update emp20vw set deptno=30
	  where empno=7566;

	
[7] INLINE VIEW

	- ����Ŭ������ FROM���� VIEW�� ������ ���ǹ��� 
	  ���� ����� �� �ֵ��� �����Ѵ�.

	- ���� ���� [����A]�� ��� �Ʒ��� ���� 
	  �ζ��� �並 ����ϸ� ������
	   ���� �� �ִ�.

	   SELECT * FROM (
		  SELECT * FROM EMP ORDER BY HIREDATE
	  ) EMP_VW WHERE ROWNUM <11;

	... ���⼭ EMP_VW�� FROM���� ()�� ���ǿ� ���� ��Ī�̴�.
	�̸� INLINE VIEW��� �Ѵ�. �ζ��� ��� VIEW�� ����� 
	��ü ���ǿ��� ������ �� �ֵ��� ���ش�.
	���� �Ź� ������ VIEW�� �������� �ʾƵ� �ȴ�.

[8] VIEW�� ���� DML���� ��� ���̵����
   VIEW�� �Ʒ� ������ �����ϴ� ��� DML������ �Ұ����ϴ�.

   (1)���� ���� �Ұ����� ���
      GROUP BY��, GROUP�Լ�, DISTINCT���, JOIN����
   (2) ������ ������ �Ұ����� ���
      GROUP BY��, GROUP�Լ�, DISTINCT���, JOIN����,
      ǥ�������� ���ǵ� Į��(SAL*1.1),
      ROWNUM�� �ǻ翭

   (3) ������ �߰��� �Ұ����� ���	 
      GROUP BY��, GROUP�Լ�, DISTINCT���, JOIN����,
      ǥ�������� ���ǵ� Į��(SAL*1.1),
      ROWNUM�� �ǻ翭, 
      view���� ���õ��� �ʴ� not null �÷�
  
////////////////////////////////
# INDEX
[1] �ε�����?
 .. ���̺� ���� ������ �����ϵ��� �ϴ� �����ͺ��̽� ��ü.	
    ��, ���� ���� �����͸� �˻��� �� �ֵ��� �����ִ� 
    ������ ����.
    �Ϲ� �������� ABCD ������ ���ĵǸ� �ܾ ã�� �� 
    �˻��� �����ϵ�,
    SQL������ �ε����� �̿��Ͽ� �����͸� �ż��ϰ� 
    �˻��ϵ��� �Ѵ�.
    
    �� Ư�� ���̺��� �ε����� �̿��ϸ� �÷��� 
    �ڷᰡ ���ο��� ����������
    ���ĵǾ� �ڷ� �˻���, ���ĵ� ���� �̿��� �ڷḦ 
    �˻��� �� �ִ�.
    �ε����� �������� �����Ͽ� ����ϸ� 
    ������ ���Ͽ� ���� I/O�� ���� �� �ְ� ������ 
    ����ų �� �ִ�.

    �׷��� ���̺� ������ �ε��� ����� ���̺� 
    �Է�,����,������ �� ������ ���� �����ϸ� �߻���ų �� ����.
    ���� ����,��� �ε����� ������ �ϴ��� 
    �� ����ؼ� ����ؾ� ��.

    1)�ε����� ���̺� ����
      - ������ ���� ���� ����� �������� ��� 
        ���̺� �ε����� �����
        (���̺� ��ü ���� 10~15%�̸��� 
	�˻� ����� �Ǵ� ���)

      - ������ ���� ���̺����� �ε����� ���� �ʴ´�.
      - WHERE���� ���� ���Ǵ� 
       ���̺� ���� �ε����� �����Ѵ�.
    
    2) �ε����� �÷��� ����
      - WHERE ������ ���� ����ϰ� 
        �����Ǵ� �÷��� �����Ѵ�.
      - ������ ���� ���� ���� ���� �÷��� 
        �ε������� �ʴ´�.
      - ������ ���� ���� �÷��� �ε����� �����
      - �� �� �̻��� ���̺��� �����ϱ� ���� 
        ���Ǵ� �÷��� �ε����Ѵ�.
      - ���� �����Ǵ� �÷��� �ε��� ���� �ʴ´�.

* �ε��� ������ ���ʿ��� ���
	- ���̺��� ���� ��
	- ���̺��� ���� ���ŵ� ��

    3) INDEX ����

	- �ڵ� ����: 
	  PK�� UNIQUE ���� ������ �����ϸ� UNIQUE �ε�����
	  �ڵ������� �����ȴ�.
	- ����ڰ� ����: 
	  COLUMN�� UNIQUE�ε��� �Ǵ� NON-UNIQUE �ε�����
	  �����Ѵ�.
	* unique index : ������ ���� ���� �������� ����
	* non-unique index: ������ ���� ���� �ߺ��� ���
	-�������

	CREATE INDEX �ε����� ON ���̺��(�÷���[,�÷���]...)

	**����: �ε����� NOT NULL�� �÷����� 
	  ����� �� �ִ�.
	  NULL�� ��쿡�� �ε����� ������ �� ���� 
	  ������ ��� �Ұ�.

	  create index emp_ename_idx on emp (ename);

	103]
	�� ���̺� �ִ� �÷� �� NAME �÷��� �ε����� ���弼��.
	CREATE INDEX MEMBER_IDX1 ON MEMBER(NAME);

	�ε��� ������ ����Ŭ�� ���������� �Ʒ� ���� �����Ѵ�.
	- �ε����� ������ �÷� NAME���� �� �д´�.
	- NAME�÷� ���� ���� �������� ������ �Ѵ�.
	- ROWID�� NAME���� �����ϱ� ���� ��������� �Ҵ��Ѵ�.
	- �Ҵ� �� ���� �����Ѵ�.
	103_1]
	�� ���̺� �ִ� �÷� �� NAME �÷��� 
	�ε����� ���弼��.
	CREATE INDEX MEMBER_IDX2 ON MEMBER(USERID);

	**�� ����������� Ȯ��**
	   �ε����� Ȯ��
	- SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS
	   WHERE OBJECT_TYPE='INDEX';
	   �Ǵ�
	   select index_name,uniqueness from user_indexes
	   where table_name='EMP';

	   ������ �ε��� �÷������� ������ ������ USER_IND_COLUMNS�� ���� Ȯ�� ����
        -SELECT TABLE_NAME, COLUMN_NAME FROM USER_IND_COLUMNS
	  WHERE INDEX_NAME='MEMBER_IDX1';

	  ���̺�� ���õ� �ε��� ���� Ȯ��
	-SELECT TABLE_NAME,COLUMN_NAME,INDEX_NAME FROM USER_IND_COLUMNS
	  WHERE TABLE_NAME='PRODUCTS';

	**���� �̸��̳� ���̵�� ������ ���̺��� �ߺ��Ǵ� ���� 
	   ���� �����鼭
	   �˻����� ���Ǵ� �÷��̹Ƿ� �ε����� ����ϸ� ȿ����.

	104]
	��ǰ ���̺��� �ε����� �ɾ�θ� ���� �÷��� ã�� �ε����� ���弼��.
	CREATE INDEX PRODUCTS_IDX1 ON PRODUCTS(CATEGORY_FK);
	CREATE INDEX PRODUCTS_IDX2 ON PRODUCTS(EP_CODE_FK);

    4) INDEX ����	
	
	DROP INDEX ������ �ε�����

	�ε����� ������ �� ����. �ε����� �����ϱ� ���ؼ���
	�ε����� �����ϰ� �ٽ� �ۼ��ؾ� �Ѵ�.
	DROP INDEX ������ �����Ͽ� �����ͻ������� �ε��� ���Ǹ�
	�����Ѵ�.
	�ε����� �����ϱ� ���ؼ��� �ε��� �������̰ų�
	DROP ANY INDEX������ ������ �Ѵ�.
//////////////////////////////////////////////////////////////////////////
# SYNONYM(���Ǿ�)

- ����Ŭ ��ü(���̺�,��,������,���ν���)�� ����
  ��ü�̸�(ALIAS)�� �ǹ�
  ��, ��ü�� ���� ������ �ǹ��Ѵ�.
  �ٸ� ������ ��ü�� ������ �� ���� ����Ѵ�.

- ���Ǿ ���� ����
  1) ��ü�� �� �̸��� ������ �̸����� �����Ͽ�
     SQL�ڵ��� �ܼ�ȭ��ų �� �ִ�.
  2) ��ü�� �����ϴ� ������� ������Ʈ�� ���� ��
     �־� ������ ������ �� �ִ�.
- ����
  CREATE [PUBLIC] SYSNONYM �ó�Ը�
  FOR object_name;

  PUBLIC: ��� ����ڰ� ���� ������ �ó���� ����
          �Ѵ�. PUBLIC�ó���� ����,������ DBA����
	  �� �� �ִ�.

- �ǽ�-----------------------------
1> ���� system���� �����Ͽ�
	����� mystar�� �����ϰ� ������ ����.
conn system/h301`
create user mystar identified by mystar;
grant connect, resource to mystar;

2>mystar�� �����Ͽ� note��� ���̺� ��ü�� ����
  �ϰ� ���ڵ带 insert����.

conn mystar/mystar
create table note(
	no number,
	msg varchar2(30)
);
insert into note values(1,'�ȳ��ϼ���?');
insert into note values(2,'�氡 �氡 ^^');
commit;
3> mystar����ڰ� scott����ڿ��� note���̺���
   ������ ������ ����.-ojbect����
conn mystar/mystar
grant all on note to scott;

3_2>conn scott/tiger
SELECT * FROM mystar.note;

CREATE synonym A FOR mystar.note;
=>ORA-01031: insufficient privileges

4>system���� �����Ͽ� scott���� ���Ǿ ������
  ������ �ش�.-system����
conn system/h301`
grant create synonym to scott;

5>scott/tiger�� �����Ͽ� mystar�� note���̺�
  ���� ���Ǿ �����Ѵ�.
conn scott/tiger
create synonym A for mystar.note;
==> mystar������� note���̺��� scott����ڰ�
    A��� ���Ǿ�� ����ϰڴ� �ǹ�

6> ���Ǿ �̿��� ���� ����
select * from A;
==>�Ʒ��� �����ϴ�.
select * from mystar.note;
-----------------------------------------------
**�����ͻ������� ��ȸ*****
select * from user_objects
where object_type='SYNONYM';
**************************
���Ǿ� ����
DROP SYNONYM �ó�Ը�;





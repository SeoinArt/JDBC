--day07_DDL.sql
DDL: create, alter, drop, truncate, rename

# ���̺� ���� - ��������
<1> �÷� ���ؿ��� �����ϴ� ���
<2> ���̺� ���ؿ��� �����ϴ� ���

[1] primary key
- unique�� �� + not null

    <1> �÷� ����
        �÷��� constraint �������Ǹ� ������������,
        ...
    create table test_tab1(
        id number(2) constraint test_tab1_id_pk primary key, 
        name varchar2(20),
        tel char(15)
    );
    
    desc test_tab1;
    insert into test_tab1 values(3,'ȫ�浿',null);
    
    select * from test_tab1;
    
    -- ������ ����(data dictionary) ���� Ȯ��
    
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TEST_TAB1';

    <2> ���̺� ���ؿ��� ����
    
    CREATE TABLE TEST_TAB2(
        ID NUMBER(2),
        NAME VARCHAR2(20),
        TEL CHAR(15),
        -- �������� ���
        CONSTRAINT TEST_TAB2_ID_PK PRIMARY KEY (ID)
    );
    
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TEST_TAB2';


CREATE TABLE TEST_TAB3(
    ID NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(20)
);
CREATE TABLE TEST_TAB4(
    ID NUMBER(2),
    NAME VARCHAR2(20),
    PRIMARY KEY(ID)
);  
    
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TEST_TAB4'; 
---------------------------------------------
[2] FOREIGN KEY

-- MASTER TABLE
/*
DEPTNO NUMBER(2)
DNAME CHAR(20)
LOC CHAR(15)
���̺� ���ؿ��� DEPTNO=> pk �ֱ�
*/

CREATE TABLE DEPT_TAB(
    DEPTNO NUMBER(2),
    DNAME CHAR(20),
    loc CHAR(15),
    CONSTRAINT DEPT_TAB_DEPTNO_PK PRIMARY KEY (DEPTNO)
);
-- DETAIL TABLE
CREATE TABLE EMP_TAB(
    EMPNO NUMBER(4) CONSTRAINT EMP_TAB_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(10),
    -- �÷������� ����(fk)
    MGR NUMBER(4) CONSTRAINT EMP_TAB_MGR_FK REFERENCES EMP_TAB (EMPNO),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),
    --���̺� ������ ����(fk)
    constraint emp_tab_deptno_fk foreign key(deptno) references dept_tab (deptno)
);
-- ������ �������� ��ȸ
select * from user_constraints where table_name='EMP_TAB';


ON DELETE CASCADE �ɼ�
-- �θ� ���̺�
CREATE TABLE BOARD(
NUM NUMBER(4) PRIMARY KEY,
TITLE VARCHAR2(100) NOT NULL,
CONTENT VARCHAR2(1000),
WDATE DATE DEFAULT SYSDATE);

-- �ڽ� ���̺�
CREATE TABLE REPLY(
    RNUM NUMBER(4) PRIMARY KEY,    
    RCONTENT VARCHAR2(1000),
    RWDATE DATE DEFAULT SYSDATE,
    NUM_FK NUMBER(4) REFERENCES BOARD(NUM) ON DELETE CASCADE
);

ON DELETE CASCADE �ɼ��� �ָ� �ڽ� ���ڵ尡 �־
�θ��� ���ڵ带 ������ �� ������, �̶� �ڽ� ���ڵ嵵 ���� �����ȴ�

INSERT INTO BOARD(NUM,TITLE,CONTENT)
VALUES(1,'ù �� �Դϴ�','�ȳ��ϼ���?');

INSERT INTO BOARD(NUM,TITLE,CONTENT)
VALUES(2,'�ι�° �� �Դϴ�','�ݰ����ϴ�');

COMMIT;
SELECT * FROM BOARD;

--1�� �ۿ� ���� ��� 2��
INSERT INTO REPLY(RNUM,RCONTENT,NUM_FK)
VALUES(1,'����Դϴ�1',1);

INSERT INTO REPLY(RNUM,RCONTENT,NUM_FK)
VALUES(2,'����Դϴ�2',1);

2�� �ۿ� ���� ��� 1��
INSERT INTO REPLY(RNUM,RCONTENT,NUM_FK)
VALUES(3,'���� �ݰ�����~',2);

SELECT * FROM REPLY;

BOARD �� REPLY JOIN�ؼ� �����ּ���

SELECT B.*, R.*
FROM BOARD B LEFT OUTER JOIN REPLY R
ON B.NUM = R.NUM_FK;

-- BOARD���̺��� 1�� �Խñ��� �����ϼ���
DELETE FROM BOARD WHERE NUM=1;
------------------------------------------
[3] UNIQUE KEY 

<1> �÷� ���� ����

CREATE TABLE UNI_TAB1(
    NO NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    USERID VARCHAR2(16) CONSTRAINT UNI_TAB1_USERID_UK UNIQUE,
    TEL CHAR(15)
);

CREATE TABLE UNI_TAB22(
    NO NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    USERID VARCHAR2(16) CONSTRAINT UNI_TABLE_USERID_UK22 UNIQUE,
    TEL CHAR(15)
);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='UNI_TAB1';

INSERT INTO UNI_TAB1
VALUES(1,'ȫ�浿','HONG',NULL);

INSERT INTO UNI_TAB1
VALUES(2,'ȫ����','HONG2',NULL);

INSERT INTO UNI_TAB1
VALUES(4,'�̱浿',NULL,NULL);

SELECT * FROM UNI_TAB1;
COMMIT;

<2> ���̺� ������ ����
CREATE TABLE UNI_TAB2(
    NO NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    USERID VARCHAR2(16),
    TEL CHAR(15),
    CONSTRAINT UNI_TAB2_USERID_UK UNIQUE (USERID)
);
-----------------------------------------------------------
[4] NOT NULL
- �÷����ؿ����� ���� �����ϴ�.

create table nn_tab(
    deptno number(2) primary key, -- unique + not null
    dname varchar2(20) constraint nn_tab_dname_nn not null,
    loc varchar2(30) not null
);

select * from user_constraints where table_name='NN_TAB';
INSERT INTO NN_TAB VALUES(10,'ACCOUNTING','NEW YORK');
COMMIT;
SELECT * FROM NN_TAB;

[5] CHECK
<1> �÷� ������ ����
CREATE TABLE CK_TAB1(
    DEPTNO NUMBER(2) CONSTRAINT CK_TAB1_DEPTNO_CK CHECK ( DEPTNO>0 AND DEPTNO <21),
    DNAME CHAR(20),
    LOC CHAR(20)
);
select * from user_constraints where table_name='CK_TAB1';

INSERT INTO CK_TAB1 VALUES(20,'ACCOUNTING','LA');
COMMIT;
SELECT * FROM CK_TAB1;

<2> ���̺� ������ ���� : CK_TAB2
--DEPTNO���� 10,20,30,40 ���� ������ CHECK���������� ���̺� ���ؿ��� �ּ���
CREATE TABLE CK_TAB2(
    DEPTNO NUMBER(2),
    DNAME CHAR(20),
    LOC CHAR(20),
    CONSTRAINT CK_TAB2_DEPTNO_CK CHECK ( DEPTNO IN (10,20,30,40))
);
INSERT INTO CK_TAB2 VALUES(11,'SALES','SEOUL');

SELECT * FROM CK_TAB2;

------------------------------------------
ALTER ����

[1] �������� �߰�
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ������������ (�÷���);

CREATE TABLE USER_TAB(
    ID NUMBER(4),
    NAME VARCHAR2(20),
    TEL CHAR(15)
);
DESC USER_TAB;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_TAB';

USER_TAB�� ID �÷��� PRIMARY KEY ���������� �߰��ϼ���

ALTER TABLE USER_TAB
ADD CONSTRAINT USER_TAB_ID_PK PRIMARY KEY (ID);

[2] �������� �̸� ����
ALTER TABLE ���̺�� RENAME CONSTRAINT �����������Ǹ� TO �� �������Ǹ�;
--USER_TAB_ID_PK �̸����� USER_TAB_PK�� �����ϼ���
ALTER TABLE USER_TAB RENAME CONSTRAINT USER_TAB_ID_PK TO USER_TAB_PK;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_TAB';

[3] �������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

--USER_TAB�� PRIMARY KEY ���������� �����ϼ���

ALTER TABLE USER_TAB DROP CONSTRAINT USER_TAB_PK;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_TAB';
------------------------------------------------------------
# �÷� �߰�/����/����

	- ALTER TABLE ���̺�� ADD (�߰��� �÷� ���� [default expr])
	- ALTER TABLE ���̺�� MODIFY (������ �÷� ���� [default expr])
	- ALTER TABLE ���̺�� DROP (column ������ �÷���)
    - ALTER TABLE ���̺�� RENAME COLUMN OLD�÷��� TO NEW�÷���  
    
CREATE TABLE BOARD_TAB(
    NO NUMBER
);

DESC BOARD_TAB;
--
--[1] BOARD_TAB�� TITLE VARCHAR2(100) NOT NULL  �÷��� �߰��ϼ���
ALTER TABLE BOARD_TAB ADD TITLE VARCHAR2(100) NOT NULL;
--[2] BOARD_TAB�� NAME VARCHAR2(20) �÷��� �߰��ϼ���
ALTER TABLE BOARD_TAB ADD NAME VARCHAR2(20);
--[3] NO�÷����� NUM���� �����ϼ���
ALTER TABLE BOARD_TAB RENAME COLUMN NO TO NUM;
--[4] NUM�� �÷� �ڷ����� CHAR(10)���� �����ϼ���
ALTER TABLE BOARD_TAB MODIFY NUM CHAR(10);
--[5] NAME�÷��� �����ϼ���
ALTER TABLE BOARD_TAB DROP COLUMN NAME;

DESC BOARD_TAB;


--# ��ü �̸� ����=> ���̺� �̸� ����
--RENAME OLD_NAME TO NEW_NAME

--BOARD_TAB ���̺� �̸��� BBS_TAB���� �����ϼ���
RENAME BOARD_TAB TO BBS_TAB;
DESC BOARD_TAB;
DESC BBS_TAB;

SELECT * FROM TAB;
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

# ���̺� ����
DROP TABLE ���̺�� [CASCADE CONSTRAINT]

BBS_TAB�� �����ϼ���

DROP TABLE BBS_TAB CASCADE CONSTRAINT;
SELECT * FROM TAB;

--DROP TABLE ���̺�� PURGE;

# TRUNCATE TABLE ���̺��;
DELETE TABLE�� ������

SELECT * FROM EMP2;

DELETE FROM EMP2;

ROLLBACK;

truncate table emp2;
-- ���̺� ������ ����� �����Ͱ� ��� ������
-- ddl �����̹Ƿ� rollback�� �ȵȴ�
rollback;

CREATE TABLE zipcode(
    post1 CHAR(3),
    post2 CHAR(3), 
    addr VARCHAR2(60) CONSTRAINT zipcode_addr_nn NOT NULL,
    CONSTRAINT zipcode_post_pk PRIMARY KEY (post1, post2)
);

CREATE TABLE member_tab(
    id NUMBER(4,0) CONSTRAINT member_tab_id_pk PRIMARY KEY,
    name VARCHAR2(10), 
    gender CHAR(1) 
    CONSTRAINT member_tab_gender_ck CHECK(gender IN ('F', 'M')),
    jumin1 CHAR(6),
    jumin2 CHAR(7),
    tel VARCHAR2(15),
    post1 CHAR(3),
    post2 CHAR(3),
    addr VARCHAR2(60),
    CONSTRAINT member_tab_jumin_uk UNIQUE(jumin1, jumin2),
    CONSTRAINT member_tab_post_fk FOREIGN KEY (post1, post2)
    REFERENCES zipcode (post1, post2)
);
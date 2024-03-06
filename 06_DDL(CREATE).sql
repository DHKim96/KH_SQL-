/*
    * DDL
        : ������ ���� ���
          ����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE)
                                ������ �����ϰ�(ALTER)
                                ���� ��ü�� ����(DELETE)
         ��, ���� ������ ���� �ƴ� ��Ģ ��ü�� �����ϴ� ���
         
         ����Ŭ������ ��ü(����)
            : ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����, ���ν���, �Լ�, ���Ǿ�, �����
            
        <CREATE>
            : ��ü�� ���� �����ϴ� ����
*/

/*
    1. ���̺� ����
        1.1. ���̺��̶�?
                : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                  ��� �����͵��� ���̺��� ���ؼ� �����
                  (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
        1.2. ���̺� ����
                : CREATE TABLE ���̺��(
                        �÷��� �ڷ���(ũ��),
                        �÷��� �ڷ���(ũ��),
                        �÷��� �ڷ���, ...
                    }
                * �ڷ���
                    - ����(CHAR(����Ʈ ũ��) | VARCHAR2(����Ʈ ũ��))
                        **CHAR
                            : �ִ� 2000BYTE���� ���� ����
                              ��������(������ ���� ���� �����Ͱ� ��� ���)
                              ������ ũ�⺸�� �� ���� ���� ������ �������ζ� ä���� ó�� ������ ũ�⸦ �������
                        **VARCHAR2
                            : �ִ� 4000BYTE���� ���� ����
                              ��������(�� ������ �����Ͱ� ����� �𸣴� ���)
                              ��� ���� ���� ���� ũ�Ⱑ ������
                    - ����(NUMBER)
                    - ��¥(DATE)
                    
               
*/
             
-- ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER ����
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;

DROP TABLE MEMBER;

/* 
    ������ ��ųʸ�
        : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
*/

SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS;
--------------------------------------------------------------------------------
/*
    2. �÷��� �ּ��ޱ�(�÷��� ���� ������ ����)
    
        [ǥ����]
        COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
        (�߸� �ۼ� �� ���� ���� ����)
*/

    COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
    -- > MEMBER ���̺� MEN_NO �÷��� ȸ����ȣ��� �ڸ�Ʈ�� �޸�
    COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
    COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
    COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
    COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
    COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
    COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
    COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

/* 
    ���̺� �����ϰ��� �� ��
       : DROP TABLE ���̺��;
*/
DROP TABLE MEMBER;

/*
    ���̺� �����͸� �߰��ϴ� ����
        : INSERT INTO ���̺�� VALUES(��1, ��2, ...)
            (�̶� ������ �÷� ������� �׿� �´� Ÿ���� �����͵��� �����ؾ� ��)
*/

INSERT INTO MEMBER
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/02/23');
    
SELECT * FROM MEMBER;

INSERT INTO MEMBER
VALUES(2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL, SYSDATE);

--------------------------------------------------------------------------------
/*
    <���� ����>
        : ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
          ������ ���Ἲ ������ �������� ��
          
          ���������� �ο��ϴ� ����� ũ�� 2���� ����(�÷� ���� ��� / ���̺� ���� ���)
          
    1. ����
        : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    1.1. NOT NULL ��������
        : �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, ���� NULL�� ������ �ȵǴ� ���)
          ���� / ���� �� NULL ���� ������� �ʵ��� ����
        
         NOT NULL �� ������ �÷� ���� ������θ� ����
*/


CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOTNULL
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM');

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL);

INSERT INTO MEM_NOTNULL
VALUES(2, NULL, 'PASS2', 'ȫ���', NULL, NULL, NULL);
-- ���̵� NULL �� �������� �ǵ��� ���� �߻�(NOT NULL �������ǿ� ����Ǿ� ���� �߻�)

INSERT INTO MEM_NOTNULL
VALUES(3, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL);
-- ���̵� �ߺ��Ǿ������� �ұ��ϰ� �߰���

-----------------------------------------------------------------------------
/*
    1.2. UNIQUE ��������
        : �ش� �÷��� �ߺ��� ���� ������ �ȵ� ��� ���
          �÷����� �ߺ����� �����ϴ� ��������
          ���� / ���� �� ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ������ �߻���Ŵ
          �÷� ���� / ���̺� ���� ��� ��� ����
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷� ���� ���
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- UNIQUE(MEM_ID) -- ���̺� ���� ���
);

INSERT INTO MEM_UNIQUE
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM');


SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE
VALUES(2, 'USER1', 'PASS2', 'ȫ���', '��', NULL, NULL);
-- UNIQUE ���� ���ǿ� ����Ǿ����Ƿ� INSERT ����
-- ���� unique constraint (KH.SYS_C007028) violated ����
-- SYS_C007028 �� ���� ������ �̸���
-- > ���� �ľ��ϱⰡ �����
--> �������� �ο��� ���� ���Ǹ��� ���������� ������ �ý��ۿ��� �̸��� �ο���

--------------------------------------------------------------------------------
/*
    * �������� �ο��� �������Ǹ���� �����ִ� ���
    
     > �÷��������
        CREATE TABLE ���̺��(
            �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
        )
        
    > ���̺� ���� ���
        CREATE TABLE ���̺��(
            �÷��� �ڷ���,
            �÷��� �ڷ���,
            [CONSTRAINT �������Ǹ�] ��������(�÷���)
        )
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL, -- �÷� ���� ���
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- ���̺� ���
);

INSERT INTO MEM_UNIQUE
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM');

INSERT INTO MEM_UNIQUE
VALUES(2, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL);

INSERT INTO MEM_UNIQUE
VALUES(3, 'USER3', 'PASS3', '�谳��', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE
VALUES(4, 'USER4', 'PASS4', '�ְ���', NULL, NULL, NULL);

SELECT * FROM MEM_UNIQUE;

--------------------------------------------------------------------------------
/*
    1.3. CHECK(���ǽ�)
        : �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����
          �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
          �÷����� ���̺��� ����
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER  NOT NULL,
    MEM_ID VARCHAR2(20)  NOT NULL,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')), -- ��, ��
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- CHECK(GENDER IN ('��', '��')) ����
);

INSERT INTO MEM_CHECK
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM');

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(2, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL);
--> CHECK ���� ���ǿ� ����Ǿ� ���� �߻�
--> ���� GENDER �÷��� �����͸� �ְ��� �Ѵٸ� CHECK ���� ���ǿ� �����ϴ� ���� �־�� ��

INSERT INTO MEM_CHECK
VALUES(2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL);
--> NULL�� �� ��ü�� ���ٴ� �ǹ��̱� ������ CHECK ���� ���ǿ��� �ɷ����� �ʰ�
--> ���� NOT NULL ������ �ο��ؾ� �Ÿ� �� ����

--------------------------------------------------------------------------------
/*
    1.4. PRIMARY KEY(�⺻Ű) ��������
        : ���̺��� �� ��(ROW)�� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ���� ����(�ĺ��� ����)
        
          EX) ȸ����ȣ, �й�, ����, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �ù������ȣ, �����ȣ ��� ...
          
          PRIMARY KEY ���� ������ �ο� -> NOT NULL + UNIQUE �� ����
          
          �� ���ǻ���
            : �� ���̺�� ���� �� ���� ���� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20)  NOT NULL,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
    -- �Ǵ� PRIMARY KEY(MEM_NO)
);

INSERT INTO MEM_PRI
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM');

INSERT INTO MEM_PRI
VALUES(1, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL);
-- > �⺻Ű�� �ߺ����� �������� �� �� unique �������� ���� ���� ����

INSERT INTO MEM_PRI
VALUES(NULL, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL);
-- > �⺻Ű�� NULL �� �������� �� �� NOT NULL �������� ���� ���� ����

INSERT INTO MEM_PRI
VALUES(2, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL);

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20)  NOT NULL,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID),
    PRIMARY KEY(MEM_NO, MEM_ID)
);
/* 
    1.4.1. ����Ű
        : �� �� �̻��� �÷��� ���ÿ� �ϳ��� �⺻Ű�� �����ϴ� ��
*/
INSERT INTO MEM_PRI2 VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(1, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2, 'USER3', 'PASS3', 'ȫ���', NULL, NULL, NULL);

-- ����Ű ��� ����(� ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�)
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);
-- ȸ�� 2��(1��, 2��) ����
-- ����A, ����B ��ǰ ����

INSERT INTO TB_LIKE VALUES(1, '������A', SYSDATE);
SELECT * FROM TB_LIKE;
INSERT INTO TB_LIKE VALUES(1, '������B', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '������A', SYSDATE);
-- > UNIQUE ���� �߻� WHY? MEM_NO, PRODUCT_NAME ���ڰ� ��� ���� ������

-------------------------------------------------------------------------------

-- ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

DROP TABLE MEM_GRADE;

INSERT INTO MEM_GRADE VALUES (10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES (20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES (30, 'Ư��ȸ��');


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20)  NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ���', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02', 'ȫ�浿', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03', '������', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04', '������', NULL, NULL, NULL, 40);
--- ��ȿ�� ȸ����޹�ȣ�� �ƴϾ INSERT�� �ߵ�

--------------------------------------------------------------------------------
/*
        1.5. FOREIGN KEY(�ܷ�Ű) ���� ����
            : �ٸ� ���̺� �����ϴ� ���� ���;��ϴ� Ư�� �÷��� �ο��ϴ� ���� ����
             -> �ٸ� ���̺��� �����Ѵٰ� ǥ��
             -> �ַ� FOREIGN KEY ���� �������� ���� ���̺� �� ���� ����
             
             > �÷��������
             �÷��� �ڷ��� REFERENCES ������ ���̺��[(������ �÷���)]
           
             > ���̺������
             FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
             
             -> ������ �÷��� ���� �� ������ ���̺� PRIMARY KEY �� ������ �÷��� ��Ī��
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20)  NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
-- �ܷ�Ű�� GRADE_ID �� NULL �� �����ص� �Էµ�
INSERT INTO MEM VALUES(2,'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);

INSERT INTO MEM VALUES(3,'USER3', 'PASS03', '�ְ���', '��', NULL, NULL, 40);
--> PARENT KEY ã�� �� ���ٴ� ���� ����

SELECT * FROM MEM;
-- MEM_GRADE(�θ����̺�) -|-------<- MEM(�ڽ����̺�)
--      1:N ���� 1���� �θ����̺� N���� �ڽ����̺�

INSERT INTO MEM VALUES(3,'USER3', 'PASS03', '�谳��', '��', NULL, NULL, 20);

INSERT INTO MEM VALUES(4,'USER4', 'PASS04', '�ֹ��', '��', NULL, NULL, 10);

--> �̶� �θ����̺��� �����Ͱ��� �����ϸ� ��� �ɱ�?
-- ������ ���� : DELECT FROM ���̺�� WHERE ����;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';
-- ���� WHY? �ڽ����̺��� 10�̶�� ���� ����ϰ� �ֱ� ������ ������ �ȵ�

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '30';
--> �ڽ����̺��� 30�̶�� ���� ����ϰ� ���� �ʱ� ������ ������ ��

--> �ڽ����̺� �̹� ����ϰ� �ִ� ���� ���� ��� 
--> �θ����̺�κ��� ������ ������ �ȵǴ� "��������" �ɼ��� �ɷ�����

ROLLBACK;

/*
    �ڽ����̺� ������ �ܷ�Ű �������� �ο��� �� �����ɼ� ���� ����
    * ���� �ɼ�
        : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ��� �� ���ΰ�?
        
        - ON DELETE RESTRICTED(�⺻��)
            : ���� ���� �ɼ�, �ڽĵ����ͷκ��� ���̴� �θ����ʹ� ������ �ȵ�
        - ON DELETE SET NULL
            : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ������� ���� NULL �� ����
        - ON DELETE CASCADE
            : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ������Ű�� �ɼ�
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20)  NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);


INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2,'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3,'USER3', 'PASS03', '�谳��', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4,'USER4', 'PASS04', '�ֹ��', '��', NULL, NULL, 10);

-- 10�� ��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';
--> �� ������ �Ϸ��, 10�� ������ �����ִ� �ڽĵ������� ���� NULL �� �����

ROLLBACK;

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20)  NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20)  NOT NULL,
    MEM_NAME VARCHAR2(20)  NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2,'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3,'USER3', 'PASS03', '�谳��', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4,'USER4', 'PASS04', '�ֹ��', '��', NULL, NULL, 10);

-- 10�� ���
DELETE FROM MEM_GRADE WHERE GRADE_CODE = '10';
-- > ������ �ߵ�
-- �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ������ ��

---------------------------------------------------------------------------------
/*
    <DEFAULT �⺻��> *���������� �ƴ�
        : �÷��� ���������ʰ� NULL �� �ƴ� �⺻���� INSERT �ϰ��� �� �� �����ص� �� �ִ� ���� �⺻��
        [ǥ����]
          �÷��� �ڷ��� DEFAULT �⺻��
*/

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- INSERT INTO ���̺�� VALUES(��1, ��2, ...)
INSERT INTO MEMBER VALUES(1, '������', 20, '�', '20/01/01');
INSERT INTO MEMBER VALUES(2, '����', 22, NULL, NULL);
-- > NULL ������ ����
INSERT INTO MEMBER VALUES(3, '������', 17, DEFAULT, DEFAULT);

SELECT * FROM MEMBER;

-- INSERT INTO MEMBER(�÷�1, �÷�2, ...) VALUES(�÷�1��, �÷�2��, ...)
-- ���� ���ϴ� �÷����� �����͸� �־��� �� ����
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '�̱���');
-- > ���õ��� ���� �÷����� �⺻������ NULL �� ��
-- > ��, �ش� �÷��� DEFAULT ���� �ο��Ǿ� ���� �� NULL �� ��� DEFAULT ���� ��

-------------------------------------------------------------------------------------
-- ���̺��� ������ �� �ִ�.
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * FROM EMPLOYEE);

DROP TABLE EMPLOYEE_COPY;
-------------------------------------------------------------------------------
/*
    *���̺��� �� ������ �Ŀ� �ڴʰ� ���������� �߰��Ѵ� ���
        ALTER TABLE ���̺�� ������ ����
        
        - PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
        - FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
        - UNIQUE : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
        - CHECK : ALTER TABLE ���̺�� ADD CHECK(�÷���);
        - NOT NULL : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
*/

-- EMPLOYEE_COPY ���̺� PRIMARY KEY ���������� �߰�(EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
ALTER TABLE EMPLOYEE_COPY DROP PRIMARY KEY;
-- ������ �����ϳ� ������ų���� ���� ����

-- EMPLOYEE���̺� DEPT_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

-- EMPLOYEE���̺� JOB_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);

-- DEPARTMENT ���̺� LOCATION_ID �� �ܷ�Ű �������� �߰�
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);

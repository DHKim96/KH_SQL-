/*
    <VIEW ��>
        : SELECT��(������)�� �����ص� �� �ִ� ��ü
          (���� ����ϴ� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ䰡 ����)
          �ӽ����̺� ���� ����(���� �����Ͱ� ��� �ִ� ��(�������� ���̺�)�� �ƴ� = > ������ ���̺�)
*/

-- �ѱ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�'
ORDER BY EMP_ID;

-- ���þƿ��� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�'
ORDER BY EMP_ID;

-------------------------------------------------------------------------------
/*
    1. VIEW ���� ���
        
        [ǥ����]
        CREATE VIEW ���
        AS (��������)
        
        �ٸ�, ���̺����� ������ �����ϱ� ���� ���� ��Ī �տ� VW_ ���
*/
-- TB_ 
-- VW_

CREATE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE));
--> insufficient privileges ���� ����
--> ���� �ο��������(������ ��������)
GRANT CREATE VIEW TO KH; 

SELECT * FROM VW_EMPLOYEE;

-- ���� ����Ǵ� ���� �Ʒ��� ���� ���������� ����ȴٰ� �� �� ����
SELECT * FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
                FROM EMPLOYEE
                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                JOIN NATIONAL USING (NATIONAL_CODE)
);

SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�'
ORDER BY EMP_ID;

CREATE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE));
-- �̹� ���� �̸��� �並 ������� ������ �ȵ�
-- ������ ��
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE));
------------------------------------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
        : ���������� SELECT���� �Լ����̳� ���������� ����Ǿ� ���� ��� �ݵ�� ��Ī �����ؾ���
*/
CREATE OR REPLACE VIEW VW_EMP_JOB
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����",
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ�����"
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE));
-- ���� ���� missing right parenthesis
-- ���������� �ֱ⿡ ��Ī �ο������ ��

CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE));

SELECT *
FROM VW_EMP_JOB
WHERE �ٹ���� >= 20;

-- �� �����ϰ� ���� ��
DROP VIEW VW_EMP_JOB;
---------------------------------------------------------------------------------
/*
 ������ �並 ���� DML(INSERT, UPDATE, DELETE) ��� ����
 �並 ���� �����ϸ� ���� �����Ͱ� ��� ���̺� �ݿ���
*/

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;

SELECT * FROM VW_JOB;
-- �� ���̺�(���� �����Ͱ� ������� ����)

-- VIEW �� ���� INSERT
INSERT INTO VW_JOB VALUES ('J8', '����');

SELECT * FROM JOB;
-- ���� ���̺��� �ݿ�����

-- VIEW �� ���� UPDATE
UPDATE VW_JOB
SET JOB_NAME = '�Ƹ�����Ʈ'
WHERE JOB_CODE = 'J8';

-- �� �� ���� ������ ������ �� Ȱ������� ����

--------------------------------------------------------------------------------
/*
    * DML ��ɾ�� ���� �Ұ����� ��찡 ����
      ���� �Ұ����� ���� �Ʒ��� ����
        1. VIEW �� ���ǵ��� ���� �÷��� �����Ϸ��� ���
        2. VIEW �� ���ǵ��� ���� �÷� �� ���̽� ���̺� �� NOT NULL ���� ������ �����Ǿ��ִ� ���
        3. �������� �Ǵ� �Լ������� ���ǵ� ���
        4. �׷��Լ��� GROUP BY ���� ���Ե� ���
        5. DISTINCT ������ ���Ե� ���
        6. JOIN ���� ���� ���̺� ������ѳ��� ���
    
     ���� ��κ� VIEW �� ��ȸ �������� ����. �並 ���� DML�� �Ⱦ��� ���� ����
*/

/*
    VIEW �ɼ�
    
    [��ǥ����]
    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���
    AS ��������
     [WITH CHECK OPTION]
     [WITH READ ONLY];
     
     1)CREATE OR REPLACE
        : ������ ���� �䰡 ���� ��� ����, �������� ���� ��� ���� ����
     2) FORCE | NOFORCE
        > FORCE
            : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 ������� ��
        > NOFORCE(�⺻��)
            : ���������� ����� ���̺��� �����ϴ� ���̺��̾�߸� �䰡 ����    
     3) WITH CHECK OPTION
        : DML �� ���������� ����� ���ǿ� ������ �����θ� DML ������� ��
          ���������� ����� ���ǿ� �������� �ʴ� ������ ������ ���� �߻�
     4) WITH READ ONLY
        : VIEW �� ���� ��ȸ�� ������� ��
*/

-- 2) FORCE | NOFORCE
CREATE OR REPLACE NOFORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
-- �������� ORA-00942: table or view does not exist

-- ���������� ����� ���̺��� �������� �ʾƵ� �켱������ �䰡 ����(��� �Ұ�)
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
-- ��� : ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
-- �ϴ� SELECT �� ���� �� ���߿� ���̺� ������ �� ���

SELECT * FROM VW_EMP;
-- ��ȸ �� ���� �߻�

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);
-- ���̺� ���� �� ��� ��������
SELECT * FROM VW_EMP;

-- 3) WITH CHECK OPTION
--      : ���������� ����� ���ǿ� �������� �ʴ� ������ ������ ���� �߻�
CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;

SELECT * FROM VW_EMP;    

-- 200�� ����� �޿��� 200�������� ����(SALARY >= 3000000 �� ���� �ʴ� ����)
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;

ROLLBACK;

CREATE OR REPLACE VIEW VW_EMP
AS SELECT * 
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;

-- 200�� ����� �޿��� 200�������� ����(SALARY >= 3000000 �� ���� �ʴ� ����)
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;
-- ���� ���� ORA-01402: view WITH CHECK OPTION where-clause violation

-- 4) WITH READ ONLY
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;

DELETE
FROM VW_EMP
WHERE EMP_ID = 200;
-- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view








